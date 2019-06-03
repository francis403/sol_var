/*
   Changed applied to american fuzzy lop - wrapper for GCC and clang 
   ----------------------------------------------
	
We first instrumentalize the program so we can discern two basic blocks
While we are instrumentalizing the program we collect the blocks and see if they
are arleady present
Once we are done instrumentalizing the program we write all the basic blocks to a file (each line corresponds to a program)
When we are done writing all blocks to the file we then compare blocks between programs

 */

#define AFL_MAIN

#include "config.h"
#include "types.h"
#include "debug.h"
#include "alloc-inl.h"

#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <string.h>
#include <sys/types.h>
#include <sys/wait.h>

static u8*  as_path;                /* Path to the AFL 'as' wrapper      */
static u32  cc_par_cnt = 1;         /* Param count, including argv0      */
static u8   be_quiet,               /* Quiet mode                        */
            clang_mode;             /* Invoked as afl-clang*?            */

char **instr_programs;
int head_of_program = 0;


/* Info that is important between progs */
u8 PROG_BLOCKS[MAX_AMOUNT_OF_PROGS][MAP_SIZE];
int numb_instr = 0;

char *path_instr;

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

/**
* Get the list of blocks availabe in all programs
* Used once in the beginning
*
**/

 void getProgsBlockList(){
  printf("\tin getProgsBlockList\n");
  //shostatic rt PROG_BLOCKS[numbr_of_progs_under_test][MAP_SIZE]; // TODO -> preciso de meter isto global ou devolver e pronto
  char *line = NULL, *block = NULL;
  size_t len = 0;
  int prog = 0;

  FILE *fblocks;
  fblocks = fopen(path_instr,"r");

  if( !fblocks )  FATAL("No blocks list found");
  

  ssize_t nread;

  while ( (nread = getline(&line, &len, fblocks)) != -1 ){
    
    //printf("inside while\n");

    block = strtok(line," ");
    //printf("\nprog: %d\n, prog");
    // Get the blocks from the file
    while ( block != NULL ){
      unsigned short block_id = atoi(block);
      //printf("block = %s\n", block);
      PROG_BLOCKS[prog][block_id] = 1;
      
      for( int i = 0; i < prog ; i++){
        //printf("Does prog %d share block %d\n", i, block_id);
        if (PROG_BLOCKS[i][block_id] == 1){
          printf("prog %d shares block %d with prog %d\n",prog, block_id,i );
        }
      }
      
      //printf("%d ", block_id);
      block = strtok(NULL," ");
    }

    prog ++;
  }

  if( line ) free(line);

  fclose(fblocks);
}


/*How many blocks do they have in common*/

/* Main entry point */
// TODO -> improve code, can be greatly improved
int main(int argc, char** argv) {

  //SAYF("\n\t-----In instr-all-gcc -------\n");

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

  unsigned short prog_nbr = 0;
  char cwd[1000];
  getcwd( cwd, sizeof(cwd) );
  
  path_instr = malloc (sizeof(char) * 1500 + 1);
  sprintf(path_instr, "%s/progs_blocks.txt", cwd);
  //printf("\tpath_instr = %s\n", path_instr);

  find_as(argv[0]);

  //edit_params(argc, argv);
  short numbr_lines = 100;
  int index = 0;

  char **tmp = malloc(sizeof(char*) * numbr_lines);

  if( !tmp ){
    FATAL("malloc failed in instrumentalizing all programs");
  }

  instr_programs = malloc( sizeof(char*) * MAX_AMOUNT_OF_PROGS);

  if(!instr_programs) FATAL("malloc failed to work");

  short is_recording = 0;
  short first = 1;

  char snum[5];

  // Opens the file and clears the contents
 
  //printf("Cur dir = %s\n", getcwd(cwd, sizeof(cwd)));
  //FILE *fblocks = fopen("./progs_blocks.txt","w");


  //FILE *fblocks = fopen( "./progs_blocks.txt" ,"w");
  FILE *fblocks = fopen( path_instr ,"w");
  //printf("file = %d\n", fblocks == NULL);
  if( fblocks ){
    //printf("found file for deletion\n");
    fclose(fblocks);
  }

  //free(path_instr);

  while( *argv ){
    char *line = *argv++;
    //printf("line = %s\n", line);
    
    if( first ){first = 0; continue;}

    if( strcmp(line, "-p") == 0 ){
        prog_nbr ++;
        if(is_recording){
            

            u8** cc_params = edit_params(index, tmp);
            index = 0;
            
            tmp = malloc(sizeof(char*) * numbr_lines); //clear the pointer
            if(!tmp) FATAL("malloc failed to work");

            sprintf(snum, "%d", numb_instr);
            numb_instr ++; //leave this here so we don't have race conditions

            // in case we are runnign out of space create more
            if( index >= 0.75 * numbr_lines){
                numbr_lines *= 2;
                tmp = realloc( tmp, sizeof(char*) * numbr_lines );
            }

            pid_t pid = fork();
            if(pid == 0){
                // send the program nmbr
                setenv(FORKSRV_ENV, snum, 1);
                execvp(cc_params[0], (char**)cc_params);
                FATAL("Oops, failed to execute");
            }
            waitpid(pid,NULL,0);
            
        }
        else is_recording = 1;

        continue; 
    }
    
    *(tmp + index) = line;
    
    index++;
    
  }
 
  // this records the last one
  if(is_recording){
    //printf("\t is gonna instrumentalize the program\n");
        //printf("CC_PARAMS IS null\n");
    u8** cc_params = edit_params(index, tmp);
  
    sprintf(snum, "%d", numb_instr);
    //printf("even should be = %d\n", numb_instr);
    numb_instr ++;
    pid_t pid = fork();
    if(pid == 0){
      // send the program nmbr
      setenv(FORKSRV_ENV, snum, 1);
      execvp(cc_params[0], (char**)cc_params);
      FATAL("Oops, failed to execute");
    }
    waitpid(pid, NULL, WCONTINUED);
  }

  //TODO now we need to compare
  //printf("Before getProgsBlockList\n");
  getProgsBlockList();


  free(path_instr);
  //if (fblocks) fclose(fblocks);

  return 0;

}
