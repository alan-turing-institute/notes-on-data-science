#include <stdio.h>

int gcd(int a, int b) {
  while (a != b) {
    if (a > b) {
      a = a - b;
    } else {
      b = b - a;
    }
  }
  return a;
}

int main() {
  int a = 32;
  int b = 24;
  
  printf("%d\n", gcd(a, b));
  
  return 0;
}
