// A C program to demonstrate sumple erros

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <limits.h>

#define MAGIC_NUMBER 0xFFFF7F8F

char global_buffer[20] = {0}; //empty //only detectable if initialized

void buffer_overflow(char *buff){
	// Reserve 5 byte of buffer plus the terminating NULL. 
       // should allocate 8 bytes = 2 double words, 
       // To overflow, need more than 8 bytes... 
       char buffer[5];  // If more than 8 characters input 
                        // by user, there will be access  
                        // violation, segmentation fault 
  
      
  
       // copy the user input to mybuffer, without any 
       // bound checking a secure version is srtcpy_s() 
       strcpy(buffer, buff); 
       printf("buffer content= %s\n", buffer); 
  
       // you may want to try strcpy_s() 
       printf("strcpy() executed...\n"); 
}

void stack_overflow(const char *x)
{
    printf("Stack Overflow example\n");
    char y[strlen(x)];
    strcpy(y, x);
    printf("%s\n",y);
}


void heap_overflow(const char *x)
{
    printf("In heap overflow\n");
    if(strlen(x) <= 5){
	return;
    }
    char *y = malloc(strlen(x));
    strcpy(y, x);
}

/**
* If the string has more than 20 characters global buffer overflow
**/
void global_buffer_overflow(char *x){
	strcpy(global_buffer, x);
	printf("buffer = %s\n",global_buffer);
}

int integer_overflow(int a)
{
	if(a == 101){
		return INT_MAX + 1;	
	}
	
    return a;
}

/**
* almost Impossible to happen by chance
**/
int integer_underflow(int a)
{
    return a == 10002 ? INT_MIN - 1 : a;
}


/**
* Deleting an object from memory explicitly or by destroying
* The stack frame on return does not alter associated pointers.
* The pointer still points to the same location in memory even 
* though it may now be used for other purposes
**/
void dangling_pointer(int a){
	printf("entered dangling pointer\n");

	if (a != 10)
		return;

	char *dp = NULL;
	if( 1 ){
		char c = 'b';
		dp = &c;
	}
	/* c falls out of scope */
	/*dp is now a dangling pointer*/
	printf("%s\n",dp);
}

/**
* Allocate some memory and delibery forgotten to free it
**/
void memory_leak(){
	float *a = malloc(sizeof(float) * 45);
	float b = 42;
	a = &b;
}

char *negative_memory_allocation(){
	char *c;
	c = 'c';
	return c;
}

void use_after_free(int a){
	if(a != 10){ return; }
	char *buff = {0};
	free(buff);
	printf("%s\n",buff);
}

void out_of_bounds(int a){
	int array[20];
	array[a] = 4;
}

int division_by_zero(int a){
	if( a > 50 )
		return 2/(100 - a);
	else
		return 2/(a +1);
}

unsigned int unsigned_int(int a){
	unsigned int b = a - 10;
	return b;
}

unsigned short unsigned_overflow(int b){
	unsigned short a = 65000;
	//unsigned short b = 560;
	unsigned short c = 0;
	c = a + b;
	printf("Resukt is %hu + %hu = %hu\n", a, b, c);
	return c;
}

void truncating_unsigned(int a){
	unsigned int val = INT_MAX;
	unsigned short ss = val;
	printf("turning %d to %d\n", val, ss);
}

void sign_conversion(){
	unsigned short us = 0x8080;
	short ss = us;

	printf("%6hu %6hd\n", us, us);

}


void double_free(int i){
	char* ptr = (char*) malloc (sizeof(char) * 4 + 1);
	//ptr = "love";
	if(i == 101){
		free(ptr);
	}
	free(ptr);
}

int main(){

	int a;
	scanf("%d", &a);
	//printf("value = %d\n", integer_overflow(a));
	
	//division_by_zero(a);
	out_of_bounds(a);

	printf("after out of bounds\n");

	/*
	char *line = NULL;
	size_t len = 0;
	ssize_t read;
	if ( (read = getline(&line, &len, stdin)) != -1 ){
		// do something
	}
	char buff[len];
	strcpy(&buff, line);
	free(line);
	*/
	//stack_overflow(buff); // new fuzz -> finds fast -> < 2 secs -> no need for asac
	//heap_overflow(buff); // new fuzz -> finds fast -> < 2 secs -> no need for asac
	//buffer_overflow(buff); // new fuzz -> finds fast -> < 2 secs -> no need for asac
	//global_buffer_overflow(buff); // new fuzz -> finds fast -> < 2 secs -> no need for asac

	return 1;
}

