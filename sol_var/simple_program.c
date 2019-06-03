#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <stdio.h>
#include <limits.h>

int MAX_LINE = 150;


int add2(int val1, int val2){
	if( val1 > val2)
		return val1 - val2;
	if( val1 < val2 )
		return val2 - val1;
	if( val1 == val2 )
		return val1 * 4 - 2 * (val2 - 1);
}

int integer_overflow(int a)
{
	if(a == 101){
		return INT_MAX + 1;	
	}
	
    return a;
}

int main (int argc, char* argv[]){
	/*Code block 1*/
	int val;
	
	scanf("%d",&val);
	int a = 4 + 3;
	printf("val = %d\n", a );

	if(val < 10){
		/*Code block 2*/
		printf("val < 10 and %d\n", add2(val, 1 + val/2));
		return 0;
	}
	/*Code block 3*/
	if(val < 20){
		/*Code block 4*/
		printf("val < 20 and %d\n", add2(val, val/2));
		return 1;
	}
	/*Code block 5*/
	// este bloco é suposto ser igual ao anterior?
	if(val < 30){
		/*Code block 6*/
		printf("val < 30 and %d\n", add2(val, val/2));
		//short b = integer_overflow(101);
		return 2;
	}
	/*Code block 7*/
	if(val < 40){
		/*Code block*/
		// an error to try and encounter
		int i = 2 + 99;
		short b = integer_overflow(i);
		printf("Amazing grace\n");
		return 3;
	}
	/*Code block 8*/
	printf("love is in the air\n");

  	return 0;
}

void teste(int i){printf("Hello, Dabe");}
