/*
   american fuzzy lop - LLVM-mode instrumentation pass
   ---------------------------------------------------

   Written by Laszlo Szekeres <lszekeres@google.com> and
              Michal Zalewski <lcamtuf@google.com>

   LLVM integration design comes from Laszlo Szekeres. C bits copied-and-pasted
   from afl-as.c are Michal's fault.

   Copyright 2015, 2016 Google Inc. All rights reserved.

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at:

     http://www.apache.org/licenses/LICENSE-2.0

   This library is plugged into LLVM when invoking clang through afl-clang-fast.
   It tells the compiler to add code roughly equivalent to the bits discussed
   in ../afl-as.h.

 */

#define AFL_LLVM_PASS

#include "../config.h"
#include "../debug.h"

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

#include "llvm/ADT/Statistic.h"
#include "llvm/IR/IRBuilder.h"
#include "llvm/IR/LegacyPassManager.h"
#include "llvm/IR/Module.h"
#include "llvm/Support/Debug.h"
#include "llvm/Transforms/IPO/PassManagerBuilder.h"

#include "llvm/Support/raw_ostream.h"
#include <iostream>
#include <string.h>
#include <ctype.h>

using namespace llvm;

namespace {

  class AFLCoverage : public ModulePass {

    public:

      static char ID;
      AFLCoverage() : ModulePass(ID) { }

      bool runOnModule(Module &M) override;

      //int hash_string(char *input) override;

      // StringRef getPassName() const override {
      //  return "American Fuzzy Lop Instrumentation";
      // }
  };

}


char AFLCoverage::ID = 0;


/**
* Added by FA
* Concats two strings
**/
char *concat( char *s1, char *s2)
{
  char *result = (char*) malloc( strlen(s1) + strlen(s2) + 1 );
  if(!result) FATAL("malloc failed in concat!");
  strcpy(result, s1);
  strcat(result, s2);
  return result;
}

// adds the line to the destiny
void concatInto( char **dest, char *line ){
  char *temp = (char*) concat(*dest, line);
  //printf("%s\n", temp);
  *dest = (char*) realloc(*dest, strlen(temp) * sizeof(char) + 1); //add the line to the lines
  strcpy(*dest, temp);
  free(temp);
}

/*
* Multiplies the position (i + 1) by the ASCII of 
* the character found in that position
*/
static unsigned int hash_string(char *input){
  int hash = 0;
  //printf("gonna hash = %s\n", input);
  for( int i = 0; i < strlen(input); i++ ){
    if(input[i] == ',') continue;
    hash += (i +1) * (input[i] - 1);
  }
  return hash == 0 ? 1 : (hash % MAP_SIZE);
}

/**
* Returns the important information of the line
* O(2n) -> consigo melhorar para O(n)
* We take into consideration:
*   - The number of actually important lines
*   - 
**/
char* importantLineInfo(const char *line){

  //printf("%s\n", line);

  char *string_to_hash = (char*)  calloc(0, sizeof(char)); //string to eventually hash

  if( strstr(line, "@llvm") || strstr(line, "align") ) return string_to_hash;

  char *copy = (char*)  malloc ( sizeof(char) * strlen(line) + 1 );

  if(!copy) FATAL("malloc failed generating block ID");

  strcpy(copy, line);

  char *delim = " ";

  //printf("line start = %c\n", line[2]);

  char *command = strtok(copy, delim); //divide the line into a line

  if( strcmp(command, "br") == 0 ){

    //printf("%s ", command); // add command
    concatInto(&string_to_hash, command);
    command = strtok(NULL, delim);

    if( strcmp(command, "i1") == 0 || strcmp(command, "label") == 0 ){
      command = strtok(NULL, delim); // skip
    }
            

    while( command != NULL && command[0] != '!' ){
      if( strcmp(command, "label") != 0){
        if(command[0] == '%' && isalpha( command[1] ) ){
          int i = 1;
          char cor_cmd[strlen(command)];
          while( command[i] && command[i] != '.'){
            cor_cmd[i-1] = command[i];
            i ++;
          }
          //printf("%s ", cor_cmd); // add command  
          concatInto(&string_to_hash, cor_cmd);  
        }
      }
      command = strtok(NULL, delim);
    }
    
  } //end of br

  else if( line[2] == '%' ){ // %
    // caso especial que temos de fazer icmp and call (to get the function)

    command = strtok(NULL, delim);
    command = strtok(NULL, delim);

     if( strcmp(command, "label") == 0 || strcmp(command, "tail") == 0 ||
          strcmp(command, "nsw") == 0 || strcmp(command, "!dbg") == 0 ){
          command = strtok(NULL, delim);
      }

    if( strcmp(command, "icmp") == 0 ){
     
      //printf("line = %s\n", line);
      char *divide_by_comma = (char*)  malloc ( sizeof(char) * strlen(line) + 1 );
      strcpy(divide_by_comma, line);

      for(int i = 0; i < 3 && command != NULL ; i++){
        //printf(" command %s ", command);
        concatInto(&string_to_hash, command);
        command = strtok(NULL, delim);
      }

      char *command_div_by_comma = strtok(divide_by_comma, ","); //divide the line into a line
      for(int i = 0; i < 3 && command_div_by_comma != NULL ; i++){
        unsigned int num_cmp= atoi(command_div_by_comma);
        short isNumber = num_cmp != 0 || (command_div_by_comma[0] == '0' && strlen(command_div_by_comma) > 1) ;
        if( isNumber ){
          char str[20];
          sprintf(str, "%d", num_cmp);
          concatInto( &string_to_hash, str );
        }
        command_div_by_comma = strtok(NULL, ",");
      }


      //printf("line = %s\n", copy);

      free(divide_by_comma);

    }

    else if( strcmp(command, "call") == 0 ){

      //printf("%s ", command);
      concatInto(&string_to_hash, command); 
      command = strtok(NULL, delim);
      //printf("%s ", command);
      concatInto(&string_to_hash, command); 
      command = strtok(NULL, delim);
      for(;command != NULL;){
        
        if( command[0] == '@' ){
          int i = 1;
          char cor_cmd[strlen(command)];
          while( command[i] && command[i] != '('){
            cor_cmd[i-1] = command[i];
            i ++;
          }
          //printf("%s ", cor_cmd); // add command
          concatInto(&string_to_hash, cor_cmd);  
          //printf("%s ", command);
          break;
        }
        command = strtok(NULL, delim);
      }
    }

    else{
      int i = 0;
      
      while( command != NULL && i < 2 ){
      
        if( strcmp(command, "label") == 0 || strcmp(command, "tail") == 0 ||
          strcmp(command, "nsw") == 0 || strcmp(command, "!dbg") == 0 ){
          command = strtok(NULL, delim);
          continue;
        }
        
        if( strcmp(command, "call") == 0 ){

          //printf("%s ", command);
          concatInto(&string_to_hash, command);
          command = strtok(NULL, delim);
          //printf("%s ", command);
          concatInto(&string_to_hash, command);
          command = strtok(NULL, delim);
          for(;command != NULL;){
            
            if( command[0] == '@' ){
              //printf("%s ", command);
              concatInto(&string_to_hash, command);
              break;
            }
            command = strtok(NULL, delim);
          }
        }
      
        // if the first elem of the line is a % with an assignement
        //printf("%s ", command);
        concatInto(&string_to_hash, command);

        //concatInto(&string_to_hash, command);
        command = strtok(NULL, delim);
        i ++;
      }
    } // default

  } // end of lines strarting with %
  else{ //default
    // special cases
    // ret/ br /
    int i = 0;
    while( command != NULL && i < 2){

      if( strcmp(command, "label") == 0 || strcmp(command, "tail") == 0 ||
          strcmp(command, "nsw") == 0 || strcmp(command, "!dbg") == 0 ){
          command = strtok(NULL, delim);
          continue;
      }

      if( strcmp(command, "unreachable,") == 0 ) break;

      // if the first elem of the line is a % with an assignement
      //printf("%s ", command);
      concatInto(&string_to_hash, command);
      //concatInto(&string_to_hash, command);
      command = strtok(NULL, delim);
      i ++;
    }
  }


  //printf("\n");
  //printf("Final line string to hash: %s\n", string_to_hash);
  //free(command); 
  //printf("\n RESULT = %s\n", string_to_hash);
  //int val = hash_string(string_to_hash) % MAP_SIZE;
  free(copy);
  //free(string_to_hash);
  
  printf("result -> %s\n", string_to_hash);


  return string_to_hash;
}


bool AFLCoverage::runOnModule(Module &M) {

  LLVMContext &C = M.getContext();

  IntegerType *Int8Ty  = IntegerType::getInt8Ty(C);
  IntegerType *Int32Ty = IntegerType::getInt32Ty(C);

  /* Show a banner */

  char be_quiet = 0;

  if (isatty(2) && !getenv("AFL_QUIET")) {

    SAYF(cCYA "afl-llvm-pass " cBRI VERSION cRST " by <lszekeres@google.com>\n");

  } else be_quiet = 1;

  int srv = getenv(FORKSRV_ENV) == NULL ? 0: atoi(getenv(FORKSRV_ENV));

  char snum[5];
  sprintf(snum, "%d", srv);
  setenv(FORKSRV_ENV, snum, 1);

  printf("\n\tprogram to instrumentalize =  %d\n", srv);


  char cwd[1000];

  if( !getcwd( cwd, sizeof(cwd) ) ) FATAL("Can't find path to dir!");

  /*File of prog blocks*/
  FILE *fblocks;

  char* prog_title = getenv(FORKSRV_ENV_TITLE);
  char *path_instr = (char*)  malloc (sizeof(char) * 1500 + 1);

  
  if( prog_title == NULL ){
    // set default value
    sprintf(path_instr, "%s/progs_blocks.txt", cwd);
  }
  else{
    sprintf(path_instr, "%s/%s_blocks.txt", cwd, prog_title);
  }
  
  fblocks = fopen(path_instr,"w");

  //printf("prog_title = %s\n", prog_title);
  printf("prog_path = %s\n", path_instr);
  free(path_instr);
  /* Decide instrumentation ratio */

  char* inst_ratio_str = getenv("AFL_INST_RATIO");
  unsigned int inst_ratio = 100;

  if (inst_ratio_str) {

    if (sscanf(inst_ratio_str, "%u", &inst_ratio) != 1 || !inst_ratio ||
        inst_ratio > 100)
      FATAL("Bad value of AFL_INST_RATIO (must be between 1 and 100)");

  }

  /* Get globals for the SHM region and the previous location. Note that
     __afl_prev_loc is thread-local. */

  GlobalVariable *AFLMapPtr =
      new GlobalVariable(M, PointerType::get(Int8Ty, 0), false,
                         GlobalValue::ExternalLinkage, 0, "__afl_area_ptr");

  GlobalVariable *AFLPrevLoc = new GlobalVariable(
      M, Int32Ty, false, GlobalValue::ExternalLinkage, 0, "__afl_prev_loc",
      0, GlobalVariable::GeneralDynamicTLSModel, 0, false);

  /* Instrument all the things! */

  int inst_blocks = 0;

  for (auto &F : M){
   //printf("New F!\n");
    for (auto &BB : F) {
      //printf("New BB!\n");
      BasicBlock::iterator IP = BB.getFirstInsertionPt(); // line iterator
      IRBuilder<> IRB(&(*IP)); // creates instrunctions and inserting them into a basic block
 
      //cout << "Basic Block: " << BB << "\n";
      //printf("Basicblock:\t%d\n", BB.size()); // returns nums of line
      //printf("Basicblock:\t%d\n", BB.size()); // returns nums of line

      //BasicBlock::iterator IL = BB.getFirstInsertionPt(); // line iterator

      char *basic_block = (char*)  calloc(0, sizeof(char));

      for(BasicBlock::iterator i = BB.begin(), e = BB.end(); i != e; i++){
        Instruction *ii = &*i;
        //errs() << *ii << "\n"; // works
        //S << *ii << "\n"; //works
        //std::cout << *ii << "\n"; //doesn't work
        //printf("%s\n", (char*) *ii);

        std::string str;
        llvm::raw_string_ostream rso(str);
        ii->print(rso);

        // Get the instructions of the blocks into a string
        const char *cstr = str.c_str();
        //printf("%s\n", cstr);
        char* line_res = importantLineInfo(cstr);
        concatInto(&basic_block, line_res);
        //printf("Resulting BB: %s\n", line_res);
        free(line_res);
        //ii->print( errs() ); // works

      } // end of basic block iterator

      //printf("Resulting BB: %s\n", basic_block);
      //unsigned int cur_loc = hash_string(basic_block) % MAP_SIZE;
      //printf("temp = %d\n",temp );

      if (AFL_R(100) >= inst_ratio) continue;

      /* Make up cur_loc */

      // TODO:  need to change this so we add a specific ID
      //unsigned int cur_loc = AFL_RET(MAP_SIZE-2);
      //unsigned int cur_loc = random() % MAP_SIZE;
      //printf("%s\n", basic_block);
      unsigned int test = (hash_string(basic_block)) % MAP_SIZE ;
      const unsigned int res = test;
      u32 test2 = hash_string(basic_block);
      //unsigned int test = 4230;
      if(fblocks)   fprintf(fblocks, "%d\n", test);
      //printf("gonna be creating with: %d\n", test);

      ConstantInt *CurLoc = ConstantInt::get(Int32Ty, test );


      /* Load prev_loc */

      LoadInst *PrevLoc = IRB.CreateLoad(AFLPrevLoc);
      PrevLoc->setMetadata(M.getMDKindID("nosanitize"), MDNode::get(C, None));
      Value *PrevLocCasted = IRB.CreateZExt(PrevLoc, IRB.getInt32Ty());

      /* Load SHM pointer */

      LoadInst *MapPtr = IRB.CreateLoad(AFLMapPtr);
      MapPtr->setMetadata(M.getMDKindID("nosanitize"), MDNode::get(C, None));
      Value *MapPtrIdx =
          IRB.CreateGEP(MapPtr, CurLoc);
          IRB.CreateGEP(MapPtr, IRB.CreateOr(CurLoc, CurLoc));
          IRB.CreateGEP(MapPtr, IRB.CreateXor(PrevLoc, PrevLoc)); // or of same is same

      /* Update bitmap */

      LoadInst *Counter = IRB.CreateLoad(MapPtrIdx);
      Counter->setMetadata(M.getMDKindID("nosanitize"), MDNode::get(C, None));
      Value *Incr = IRB.CreateAdd(Counter, ConstantInt::get(Int8Ty, 1));
      IRB.CreateStore(Incr, MapPtrIdx)
          ->setMetadata(M.getMDKindID("nosanitize"), MDNode::get(C, None));

      /* Set prev_loc to cur_loc >> 1 */
      
      StoreInst *Store =
          IRB.CreateStore(ConstantInt::get(Int32Ty, test ), AFLPrevLoc);
      Store->setMetadata(M.getMDKindID("nosanitize"), MDNode::get(C, None));

      inst_blocks++;

      free( basic_block );
    } // end of for
    //printf("No new BB!\n");
  }
  //printf("No new FF!\n");
  /* Say something nice. */

  if(fblocks) fclose(fblocks);

  if (!be_quiet) {

    if (!inst_blocks) WARNF("No instrumentation targets found.");
    else OKF("Instrumented %u locations (%s mode, ratio %u%%).",
             inst_blocks, getenv("AFL_HARDEN") ? "hardened" :
             ((getenv("AFL_USE_ASAN") || getenv("AFL_USE_MSAN")) ?
              "ASAN/MSAN" : "non-hardened"), inst_ratio);

  }

  //printf("before ending function\n");

  return true;

}


static void registerAFLPass(const PassManagerBuilder &,
                            legacy::PassManagerBase &PM) {

  PM.add(new AFLCoverage());

}


static RegisterStandardPasses RegisterAFLPass(
    PassManagerBuilder::EP_OptimizerLast, registerAFLPass);

static RegisterStandardPasses RegisterAFLPass0(
    PassManagerBuilder::EP_EnabledOnOptLevel0, registerAFLPass);
