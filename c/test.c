#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <time.h>
#include <math.h>
#include <string.h>
// <C INCLUDE FUZZING>
int templateFunction(int param1)
{
	return param1;
}
typedef struct templateStruct{
	int val1;
	int val2;
	int (*fp)(int);
} templateStruct;
// <C GLOBAL FUZZING>
int main(int argc, char**argv)
{
	const const const const float;
	return 0;
}
