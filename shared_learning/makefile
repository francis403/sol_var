#Idea, make a program that gives the percentage of same code using afl-gcc
#CC=afl-clang-fast
#CC=afl-instr/instr-gcc
CC=afl-instr/instr-gcc
CC2=afl-instr/instr-gcc2
CC_AFL=afl-gcc
ALF_FUZZ=afl-fuzz
RUN=afl-instr/afl-fuzz
RUN_CLANG_FAST=afl-instr/afl-clang-fast
RUN_CLANG_FAST2=afl-instr/afl-clang-fast2
FLAGS= -static
EFLAGS=-fsanitize=address,undefined -fno-sanitize-recover=undefined -g -O0
BASE_FLAGS= -fsanitize=address -g
HARN=harn
FACT=fact


INSTR_DIR=afl-instr
ALL=$(INSTR_DIR)/instr-all-gcc


#--- Progs used for testing ---#
PROG1=./simple_program.c
PROG2=./simple_program2.c

#--- execs generated from them#
EXE=simple
EXE2=simple2


#--- CMP function info ---#
CMP_DIR=CheckProgsDiff
CMP_PROG=cmp_progs
CMP_PATH=$(CMP_DIR)/$(CMP_PROG)

#--- exec lines per program ---#
LINE_PROG1=$(PROG1) -o $(EXE) -w
LINE_PROG2=$(PROG2) -o $(EXE2) -w

main: clean simple simple2 fuzz



#------------------------ OTHER -------------------------#
simple:
	$(CC) ./simple_program.c -save-temps -o $(EXE) -w

simple2:
	$(CC2) ./simple_program2.c -save-temps -o $(EXE2) -w

vul_afl_instr:
	$(CC_AFL) ./vul.c -o vul -w 
simple_afl_instr:
	$(CC_AFL) ./$(PROG1) -o $(EXE) -w 

harness: 
	$(CC) $(EFLAGS) ./harness.c vul.c -save-temps -o $(HARN) -w

vul:
	$(ALL) $(EFLAGS) -p ./vul.c -save-temps -o vul -w

vul_fuzz:
	$(RUN) -m none -i input -o out -q 2 ./vul

factorial:
	$(CC) ./find_factorial.c -save-temps -o $(FACT) -w

#--------------------- FUZZ -----------------------------#

fuzz_before:
	$(RUN)  -i input -o out ./simple 1 2 3
fuzz_after:
	#$(RUN) -m none -i input -o out ./fact ./simple2
	$(RUN) -B "/home/francis/Documents/work/git/shared_learning/out" -i input -o out2 ./simple 1 2 3
	#$(RUN) -m none -i input -o out -q 1 -p ./simple @@
	#$(RUN) -m none -i input -o out -q 1 -p ./simple @@ -p ./simple2 @@
	#$(RUN) -m none -i input -o out ./fact ./simple2
	#$(RUN) -m none -i input -o out ./simple
	#$(RUN) -m none -i input -o out ./fact
	#$(RUN) -m none -i input -o out ./is_prime

fuzz_afl:
	$(ALF_FUZZ) -m none -i input -o out -p ./simple 

inst_afl_simple: clean
	afl-gcc ./simple_program.c -o $(EXE) -w

vul_afl_fuzz:	inst_afl_simple
	$(ALF_FUZZ) -m none -i input -o out ./simple

simple_fuzz: instr-all fuzz

vul_afl: clean vul_afl_instr vul_afl_fuzz

instr-all: clean
	#$(ALL) -p ./find_factorial.c -save-temps -o $(FACT) -w -p ./simple_program2.c -save-temps -o $(EXE2) -w
	$(ALL) -p ./simple_program.c  -save-temps -o $(EXE) -w -p ./simple_program2.c -save-temps -o $(EXE2) -w
	#$(ALL) -p ./simple_program.c -save-temps -o $(EXE) -w
	#$(ALL) -p ./find_factorial.c -save-temps -o $(FACT) -w
	#$(ALL) -p ./is_prime.c -save-temps -o is_prime -w


instr-afl-fast:
	$(RUN_CLANG_FAST) ./simple_program.c  -save-temps -o $(EXE) -w
instr-afl-fast2: 
	$(RUN_CLANG_FAST2) ./simple_program2.c  -save-temps -o $(EXE2) -w

afl-fast-delta:	clean instr-afl-fast
	$(RUN) -m none -i input -o out -q 1 -p ./simple

afl-fast-delta2: clean instr-afl-fast instr-afl-fast2
	$(RUN) -m none -i input -o out -q 1 -p ./simple -p ./simple2

afl-fast-old:	instr-afl-fast 
	$(ALF_FUZZ) -m none -i input -o out ./simple

valgrind:
	valgrind --leak-check=full ./$(CC) ./simple_program.c -o $(EXE) -w

test_as: 
	valgrind --leak-check=full gcc -O3 -funroll-loops -Wall -D_FORTIFY_SOURCE=2 -g -Wno-pointer-sign -DAFL_PATH="/usr/local/lib/afl" -DDOC_PATH="/usr/local/share/doc/afl" -DBIN_PATH="/usr/local/bin" afl-instr/test-instr.c -o test-instr -ldl -save-temps -B . -g -O3 -funroll-loops -D__AFL_COMPILER=1 -DFUZZING_BUILD_MODE_UNSAFE_FOR_PRODUCTION=1


test_memory:
	valgrind --leak-check=full --track-origins=yes -v afl-instr/afl-fuzz -m none -i input -o out -q 1 -p ./simple -p ./simple2


#-------------------- Compare Programs ------------------------#

cmp_simple_alone: clean
	./$(CMP_PATH) -p $(LINE_PROG1)

cmp_simple_pair: clean
	$(CMP_PATH) -p $(LINE_PROG1) -p $(LINE_PROG2)


#---	Coverage report	---#

cov: clean simple_afl_instr
	afl-fuzz -m none -T somebin -t 5 -i ./input/ \
	-o ./out ./simple


#--------CLEANING---------

clean: remExecutable remDir

remExecutable:
	rm -f a.out $(EXE) $(EXE2) $(FACT) $(HARN) vul

remDir:
	rm -f -r crash-* out* a.out *.i *.o *.s *bc *.txt

# ASAN_OPTIONS COMMANDS
#export ASAN_OPTIONS="detect_leaks=0:abort_on_error=1:symbolize=0:allocator_may_return_null=1"
