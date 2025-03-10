#include <stdio.h>
#include <stdlib.h>

/**
 * FizzBuzz implementation in C with command-line arguments support
 */
int main(int argc, char *argv[]) {
    int count = 100; // デフォルトは100回
    
    // コマンドライン引数を処理
    if (argc > 1) {
        count = atoi(argv[1]);
        if (count <= 0) {
            printf("Please provide a positive number of iterations\n");
            return 1;
        }
    }
    
    // FizzBuzzシーケンスを出力
    for (int i = 1; i <= count; i++) {
        if (i % 3 == 0 && i % 5 == 0) {
            printf("FizzBuzz\n");
        } else if (i % 3 == 0) {
            printf("Fizz\n");
        } else if (i % 5 == 0) {
            printf("Buzz\n");
        } else {
            printf("%d\n", i);
        }
    }
    return 0;
}