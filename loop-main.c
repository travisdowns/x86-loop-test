#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <dlfcn.h>

#define MAX_FNAME  40

typedef void (*voidcall)(void);

void foo() {
  printf("hi\n");
}


voidcall getfunc(const char *testname, int num) {
  char fname[MAX_FNAME];
  snprintf(fname, MAX_FNAME, "%s%d", testname, num);
  dlerror();
  void *fptr = dlsym(0, fname);
  if (!fptr) {
    fprintf(stderr, "Failed to find function '%s'. Error: '%s'\n", fname, dlerror());
  }
  return fptr;
}

int main(int argc, char **argv) {

  int testcase;

  if (argc != 3) {
    fprintf(stderr, "Usage: loop-main TEST-CASE-NAME LOOP-SIZE\n");
    fprintf(stderr, "\tTEST-CAST_NAME: one of dummy, short_nop_test, ...\n");
    exit(1);
  }

  const char *testname = argv[1];
  
  testcase = strtol(argv[2], NULL, 10);

  if (testcase <= 0) 
    {
      fprintf(stderr, "Bad test case: %s%d\n", testname, testcase);
    }
  else 
    {
      voidcall test = getfunc(testname, testcase);
      if (!test) 
	{
	  fprintf(stderr, "Test case not defined: %s%d", testname, testcase);
	  exit(1);
	}
      else 
	{
	  test();
	}

    }
}
