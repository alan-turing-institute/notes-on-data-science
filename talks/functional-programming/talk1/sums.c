#include <stdio.h>

int sumVals(int xs[], int len) {
  int i = 0;
  int total = 0;
  while (i < len) {
    total = total + xs[i];
    i = i + 1;
  }
  return total;
}

int sumVals2(int xs[], int len) {
  int total = 0;
  for (int i = 0; i < len; i++) {
    total = total + xs[i];
  }
  return total;
}

int xs[4] = {1, 3, 2, 8};

int main() {
  printf("%d\n", sumVals2(xs, 4));
  return 0;
}
