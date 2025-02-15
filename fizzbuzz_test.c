#include <stdio.h>
#include <string.h>
#include <assert.h>

#define TESTING
#include "fizzbuzz.c"

void test_normal_numbers() {
    char result[20];
    fizzbuzz(1, result);
    assert(strcmp(result, "1") == 0);
    fizzbuzz(2, result);
    assert(strcmp(result, "2") == 0);
    fizzbuzz(4, result);
    assert(strcmp(result, "4") == 0);
    printf("Normal numbers test passed\n");
}

void test_fizz() {
    char result[20];
    fizzbuzz(3, result);
    assert(strcmp(result, "Fizz") == 0);
    fizzbuzz(6, result);
    assert(strcmp(result, "Fizz") == 0);
    fizzbuzz(9, result);
    assert(strcmp(result, "Fizz") == 0);
    printf("Fizz test passed\n");
}

void test_buzz() {
    char result[20];
    fizzbuzz(5, result);
    assert(strcmp(result, "Buzz") == 0);
    fizzbuzz(10, result);
    assert(strcmp(result, "Buzz") == 0);
    fizzbuzz(20, result);
    assert(strcmp(result, "Buzz") == 0);
    printf("Buzz test passed\n");
}

void test_fizzbuzz() {
    char result[20];
    fizzbuzz(15, result);
    assert(strcmp(result, "FizzBuzz") == 0);
    fizzbuzz(30, result);
    assert(strcmp(result, "FizzBuzz") == 0);
    fizzbuzz(45, result);
    assert(strcmp(result, "FizzBuzz") == 0);
    printf("FizzBuzz test passed\n");
}

int main() {
    test_normal_numbers();
    test_fizz();
    test_buzz();
    test_fizzbuzz();
    printf("All tests passed!\n");
    return 0;
}