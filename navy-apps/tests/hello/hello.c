#include <unistd.h>
#include <stdio.h>

int main() {
  // write(1, "Hello World!\n", 13);
  // int i = 2;
  // volatile int j = 0;
  // while (1) {
  //   j ++;
  //   if (j == 10000) {
  //     printf("Hello World from Navy-apps for the %dth time!\n", i ++);
  //     j = 0;
  //   }
  // }
  char str[] = "this is a test";
  int a = strlen(str);
  printf("len is a\n");


  return 0;
}
