/*
   Changed applied to american fuzzy lop - wrapper for GCC and clang 
   ----------------------------------------------
	
	The idea is to instrumentalize more than one program at a time to then be tested
  Adding the Forksrv_fd of the specific file
 
  TODO -> we need to add all the blocks to a (file/shared memory) and allow the fuzzer to know what program
  has which blocks

 */

#define AFL_MAIN

#include "config.h"
#include "types.h"
#include "debug.h"
#include "alloc-inl.h"
#include <sys/wait.h>

#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <string.h>

static u8*  as_path;                /* Path to the AFL 'as' wrapper      */
static u32  cc_par_cnt = 1;         /* Param count, including argv0      */
static u8   be_quiet,               /* Quiet mode                        */
            clang_mode;             /* Invoked as afl-clang*?            */

static char *prog_name[MAX_AMOUNT_OF_PROGS];
static unsigned short numbr_lines = 100;
char **instr_programs;
int head_of_program = 0;

/* Try to find our "fake" GNU assembler in AFL_PATH or at the location derived
   from argv[0]. If that fails, abort. */

static void find_as(u8* argv0) {

   //SAYF("\n\t-----find-as-------\n");

  u8 *afl_path = getenv("AFL_PATH");
  u8 *slash, *tmp;

  if (afl_path) {

    tmp = alloc_printf("%s/as", afl_path);

    if (!access(tmp, X_OK)) {
      as_path = afl_path;
      ck_free(tmp);
      return;
    }

    ck_free(tmp);

  }

  slash = strrchr(argv0, '/');

  if (slash) {

    u8 *dir;

    *slash = 0;
    dir = ck_strdup(argv0);
    *slash = '/';

    tmp = alloc_printf("%s/instr-as", dir);

    if (!access(tmp, X_OK)) {
      as_path = dir;
      ck_free(tmp);
      return;
    }

    ck_free(tmp);
    ck_free(dir);

  }

  if (!access(AFL_PATH "/as", X_OK)) {
    as_path = AFL_PATH;
    return;
  }

  FATAL("Unable to find AFL wrapper binary for 'as'. Please set AFL_PATH");
 
}

// returns 1 if value is present, 0 otherwise
int has_value(char **array, char *value){
    int index = 0;
    //printf("in has value\n");
    //index++;
    while(*(array + index++)){
        if( strcmp(*(array + index), value) == 0){
            return 1;
        }
    }
    return 0;
}

/* Copy argv to cc_params, making the necessary edits. */
// can be improved by dividing the first bit of this function into another function
static u8 **edit_params(u32 argc, char** argv) {


  //SAYF("\n\t-----edit_params ALL -------\n");

  u8 fortify_set = 0, asan_set = 0;
  u8 *name;

#if defined(__FreeBSD__) && defined(__x86_64__)
  u8 m32_set = 0;
#endif

  u8** cc_params = ck_alloc((argc + 128) * sizeof(u8*));
  cc_par_cnt = 1;

  name = strrchr(argv[0], '/');
 
  if (!name) name = argv[0]; else name++;
  
  if (!strcmp(name, "afl-all-clang")) {

    clang_mode = 1;

    setenv(CLANG_ENV_VAR, "1", 1);

    if (!strcmp(name, "afl-all-clang++")) {
      u8* alt_cxx = getenv("AFL_CXX");
      cc_params[0] = alt_cxx ? alt_cxx : (u8*)"clang++";
    } else {
      u8* alt_cc = getenv("AFL_CC");
      cc_params[0] = alt_cc ? alt_cc : (u8*)"clang";
    }

  } else {

   

    if (!strcmp(name, "afl-g++")) {
      u8* alt_cxx = getenv("AFL_CXX");
      cc_params[0] = alt_cxx ? alt_cxx : (u8*)"g++";
    } else if (!strcmp(name, "afl-gcj")) {
      u8* alt_cc = getenv("AFL_GCJ");
      cc_params[0] = alt_cc ? alt_cc : (u8*)"gcj";
    } else {
      u8* alt_cc = getenv("AFL_CC");
      cc_params[0] = alt_cc ? alt_cc : (u8*)"gcc";
    }

  }
/*
  if(has_value(instr_programs, argv[0])){
      FATAL("instrumentation aborted, program %s is repeated at least twice, all most be different", 
            argv[0]);
      exit(0);
  }
  */
  
  *(instr_programs + head_of_program) = argv[0];
  head_of_program ++;
  
    //cc_params[0] = "gcc";
  while (--argc) {
    u8* cur = *(argv++);

    if (!strncmp(cur, "-B", 2)) {

      if (!be_quiet) WARNF("-B is already set, overriding");

      if (!cur[2] && argc > 1) { argc--; argv++; }
      continue;

    }

    if (!strcmp(cur, "-integrated-as")) continue;

    if (!strcmp(cur, "-pipe")) continue;

#if defined(__FreeBSD__) && defined(__x86_64__)
    if (!strcmp(cur, "-m32")) m32_set = 1;
#endif

    if (!strcmp(cur, "-fsanitize=address") ||
        !strcmp(cur, "-fsanitize=memory")) asan_set = 1;

    if (strstr(cur, "FORTIFY_SOURCE")) fortify_set = 1;

    cc_params[cc_par_cnt++] = cur;

  }

  cc_params[cc_par_cnt++] = "-B";
  cc_params[cc_par_cnt++] = as_path;

  if (clang_mode)
    cc_params[cc_par_cnt++] = "-no-integrated-as";

  if (getenv("AFL_HARDEN")) {

    cc_params[cc_par_cnt++] = "-fstack-protector-all";

    if (!fortify_set)
      cc_params[cc_par_cnt++] = "-D_FORTIFY_SOURCE=2";

  }

  if (asan_set) {

    /* Pass this on to instr-as to adjust map density. */

    setenv("AFL_USE_ASAN", "1", 1);

  } else if (getenv("AFL_USE_ASAN")) {

    if (getenv("AFL_USE_MSAN"))
      FATAL("ASAN and MSAN are mutually exclusive");

    if (getenv("AFL_HARDEN"))
      FATAL("ASAN and AFL_HARDEN are mutually exclusive");

    cc_params[cc_par_cnt++] = "-U_FORTIFY_SOURCE";
    cc_params[cc_par_cnt++] = "-fsanitize=address";

  } else if (getenv("AFL_USE_MSAN")) {

    if (getenv("AFL_USE_ASAN"))
      FATAL("ASAN and MSAN are mutually exclusive");

    if (getenv("AFL_HARDEN"))
      FATAL("MSAN and AFL_HARDEN are mutually exclusive");

    cc_params[cc_par_cnt++] = "-U_FORTIFY_SOURCE";
    cc_params[cc_par_cnt++] = "-fsanitize=memory";


  }

  if (!getenv("AFL_DONT_OPTIMIZE")) {

#if defined(__FreeBSD__) && defined(__x86_64__)

    /* On 64-bit FreeBSD systems, clang -g -m32 is broken, but -m32 itself
       works OK. This has nothing to do with us, but let's avoid triggering
       that bug. */

    if (!clang_mode || !m32_set)
      cc_params[cc_par_cnt++] = "-g";

#else

      cc_params[cc_par_cnt++] = "-g";

#endif

    cc_params[cc_par_cnt++] = "-O3";
    cc_params[cc_par_cnt++] = "-funroll-loops";

    /* Two indicators that you're building for fuzzing; one of them is
       AFL-specific, the other is shared with libfuzzer. */

    cc_params[cc_par_cnt++] = "-D__AFL_COMPILER=1";
    cc_params[cc_par_cnt++] = "-DFUZZING_BUILD_MODE_UNSAFE_FOR_PRODUCTION=1";

  }

  if (getenv("AFL_NO_BUILTIN")) {

    cc_params[cc_par_cnt++] = "-fno-builtin-strcmp";
    cc_params[cc_par_cnt++] = "-fno-builtin-strncmp";
    cc_params[cc_par_cnt++] = "-fno-builtin-strcasecmp";
    cc_params[cc_par_cnt++] = "-fno-builtin-strncasecmp";
    cc_params[cc_par_cnt++] = "-fno-builtin-memcmp";
    cc_params[cc_par_cnt++] = "-fno-builtin-strstr";
    cc_params[cc_par_cnt++] = "-fno-builtin-strcasestr";

  }

  cc_params[cc_par_cnt] = NULL;

  return cc_params;

}

static void compile_prog( int *index, char ***tmp, int vers ){
  u8** cc_params = edit_params(*index, *tmp);
  *index = 0;
  char snum[5];
  *tmp = malloc(sizeof(char*) * numbr_lines); //clear the pointer
  if(!*tmp) FATAL("malloc failed to work");

  sprintf(snum, "%d", vers);

  // in case we are runnign out of space create more
  if( *index >= 0.75 * numbr_lines){
    numbr_lines *= 2;
    *tmp = realloc( *tmp, sizeof(char*) * numbr_lines );
  }

  pid_t pid = fork();
  if(!pid){
    // send the program nmbr
    setenv(FORKSRV_ENV, snum, 1);
    setenv(FORKSRV_ENV_TITLE, prog_name[vers], 1);
    execvp(cc_params[0], (char**)cc_params);
    FATAL("Failed to execute!");
  }
  wait(NULL);
}

/* Main entry point */
// TODO -> improve code, can be greatly improved
int main(int argc, char** argv) {

  //SAYF("\n\t-----In instr-all-gcc -------\n");
  unsigned short num_prog_found = 0;
  //printf("\nargs in instr-all-gcc\n");

  if (argc < 2) {

    SAYF("\n"
         "This is a helper application for instr-fuzz. It serves as a drop-in replacement\n"
         "for gcc or clang, while instrumenting multiple programs, letting you recompile third-party code with the required\n"
         "runtime instrumentation. A common use pattern would be one of the following:\n\n"

         "  CC=%s/afl-gcc ./configure\n"
         "  CXX=%s/afl-g++ ./configure\n\n"

         "You can specify custom next-stage toolchain via AFL_CC, AFL_CXX, and AFL_AS.\n"
         "Setting AFL_HARDEN enables hardening optimizations in the compiled code.\n\n",
         BIN_PATH, BIN_PATH);

    exit(1);

  }
  
  int p = 0;
  while( *(argv + p) ){
      if(strcmp(*(argv + p), "-o") == 0){
        //prog_names[numbr_of_progs_under_test] =*(argv + p + 1);
        prog_name[num_prog_found] = *(argv + p + 1);
        printf("prog_name = %s\n", prog_name[num_prog_found]);
        num_prog_found ++;
      }
    p ++;
  }
  
  find_as(argv[0]);

  //edit_params(argc, argv);
  int index = 0;

  char **tmp = malloc(sizeof(char*) * numbr_lines);

  if( !tmp ){
    FATAL("malloc failed in instrumentalizing all programs");
  }

  instr_programs = malloc( sizeof(char*) * MAX_AMOUNT_OF_PROGS);

  if(!instr_programs) FATAL("malloc failed to work");



  short is_recording = 0;
  short first = 1;
  int numb_instr = 0;

  // Opens the file and clears the contents
  //FILE *fblocks;
  //fblocks = fopen("./progs_blocks.txt","w");
  //if(fblocks) fclose(fblocks);

  //while( *argv ){
  while( 1 ) {
    
    if( !*argv ){
      if(is_recording){
        compile_prog(&index, &tmp, numb_instr);
        numb_instr ++;
        return 0;
      }
    }
  
    char *line = *argv++;
    //printf("line = %s\n", line);
    
    if( first ){first = 0; continue;}

    if( strcmp(line, "-p") == 0 ){
       
        if(is_recording){
            
            compile_prog(&index, &tmp, numb_instr);
            numb_instr ++;
            
        }
        else is_recording = 1;

        continue; 
    }
    
    *(tmp + index) = line;
    
    index++;
    
  }

  FATAL("Oops, failed to execute");

  return 0;

}
