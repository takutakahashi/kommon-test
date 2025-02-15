#include <stdio.h>
#include <string.h>

void fizzbuzz(int n, char* result) {
    if (n % 15 == 0) {
        strcpy(result, "FizzBuzz");
    } else if (n % 3 == 0) {
        strcpy(result, "Fizz");
    } else if (n % 5 == 0) {
        strcpy(result, "Buzz");
    } else {
        sprintf(result, "%d", n);
    }
}

#ifndef TESTING
int main() {
    char result[20];
    for (int i = 1; i <= 100; i++) {
        fizzbuzz(i, result);
        printf("%s\n", result);
    }
    return 0;
}
#endif