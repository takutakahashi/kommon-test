package main

import (
	"flag"
	"fmt"
	"os"
	"strconv"
)

// Fizzbuzz は単一の数値を評価し、FizzBuzz文字列を返します
func Fizzbuzz(n int) string {
	if n%15 == 0 {
		return "FizzBuzz"
	}
	if n%3 == 0 {
		return "Fizz"
	}
	if n%5 == 0 {
		return "Buzz"
	}
	return strconv.Itoa(n)
}

func main() {
	// コマンドライン引数を処理
	var count int
	flag.IntVar(&count, "count", 100, "Number of iterations for FizzBuzz (default: 100)")
	flag.Parse()

	// 位置引数からカウント値を取得（フラグが未指定の場合）
	args := flag.Args()
	if len(args) > 0 && count == 100 {
		var err error
		count, err = strconv.Atoi(args[0])
		if err != nil {
			fmt.Println("Please provide a valid number")
			os.Exit(1)
		}
	}

	// 0以下の値をチェック
	if count <= 0 {
		fmt.Println("Please provide a positive number of iterations")
		os.Exit(1)
	}

	// FizzBuzzシーケンスを出力
	for i := 1; i <= count; i++ {
		fmt.Println(Fizzbuzz(i))
	}
}