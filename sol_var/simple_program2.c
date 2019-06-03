#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <stdio.h>


int MAX_LINE = 150;


int add2(int val1, int val2){
	val2 = val1;
	return val1 + val2;
}

int main (int argc, char* argv[]){
	
	int val;
	
	scanf("%d",&val);

	printf("val = %d\n", val);

	if(val < 10){
		printf("val < 10 and %d\n", add2(val, 1 + val/2));
		return 0;
	}
	if(val < 20){
		printf("val < 20 and %d\n", add2(val, val/2));
		return 0;
	}
	if(val < 30){
		printf("val < 30 and %d\n", add2(val, val/2));
		return 0;
	}
	if(val < 40){
		printf("val < 40\n");
		return 0;
	}

	printf("love is in the air\n");

  	return 0;

}

void teste(int i){printf("Hello, Dabe");}
