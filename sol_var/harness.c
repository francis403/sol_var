#include "vul.h"

#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <stdio.h>


int main (int argc, char* argv[]){
	
	if(argc == 3){
		if(strcmp(argv[1],"-s") == 0){

			printf("input: ");

			char *line = NULL;
			size_t len = 0;
			ssize_t read;
			if ( (read = getline(&line, &len, stdin)) != -1 ){
				// do something
 			}
			char buff[len];
			strcpy(&buff, line);
			free(line);

			if(strcmp(argv[2],"buff") == 0){
				buffer_overflow(buff); //found
			}
			else if(strcmp(argv[2],"stack") == 0){
				stack_overflow(buff); //found
			}
			else if(strcmp(argv[2],"heap") == 0){
				heap_overflow(buff); //found
			}
			else if(strcmp(argv[2],"global") == 0){
				global_buffer_overflow(buff); //found
			}
			else{
				printf("commands: -s <buff|stack|heap|global>\n");
			}

		}
		else if(strcmp(argv[1],"-i") == 0){
			int a;
			scanf("%d", &a);

			if(strcmp(argv[2],"int_over") == 0){
				printf("value = %d\n", integer_overflow(a)); //found
			}
			else if(strcmp(argv[2],"int_under") == 0){
				integer_underflow(a); //found
			}
			else if(strcmp(argv[2],"div_by_zero") == 0){
				int i = 4;
				int b = i + 2;
				division_by_zero(a); //found
			}
			else if(strcmp(argv[2],"use_after_free") == 0){
				use_after_free(a); //found
			}
			else if(strcmp(argv[2],"out_of_bounds") == 0){
				out_of_bounds(a); //found
			}
			else{
				printf("commands: -i <int_over|int_under|div_by_zero|use_after_free|out_of_bounds>\n");
			}

		}
		else{
			printf("commands: < -i .. | -s ..>\n");
		}
	} else if(argc == 2){
		if(strcmp(argv[1],"mleak") == 0){
			printf("memory leak start\n");
			void *pointer = malloc(sizeof(void) * 45);
			pointer=0;
		}
	}
	else{
		
		
		char *line = NULL;
		size_t len = 0;
		ssize_t read;
		if ( (read = getline(&line, &len, stdin)) != -1 ){
			// do something
		}
		char buff[len];
		strcpy(&buff, line);
		free(line);
		

		//if(rc == OK){
		//stack_overflow(buff);
		//heap_overflow(buff);
		buffer_overflow(buff);
		//global_buffer_overflow(buff);

		int a;
		//scanf("%d", &a);
		//printf("gonna call double_free\n");
		//double_free(a);
		//printf("value = %d\n", integer_overflow(a)); //finds
		//printf("%d\n",integer_underflow(a)); //finds
		//memory_leak();
		/**
		void *pointer = malloc(sizeof(void) * 45);
		pointer=10;
		printf("%d\n", pointer);
		**/
		//free(pointer);
		//dangling_pointer(a);
		//use_after_free(a);
		//negative_memory_allocation();
		//out_of_bounds(a);
		//division_by_zero(a); //finds

		//INT TESTING

		//sign_conversion();
		//printf("value = %d\n",unsigned_overflow(a));
		//truncating_unsigned(a);
		//printf("%u\n",unsigned_int(a));
	}
	
	printf("did not crash\n");
	return 0;

}
