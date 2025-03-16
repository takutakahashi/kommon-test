# コード一貫性向上のための提案

## 概要

本ドキュメントでは、FizzBuzzの各言語実装における一貫性を向上させるための提案をまとめます。現在の実装は各言語の特性を活かしつつも、型式や機能に一貫性がないため、保守性や拡張性に課題があります。

## 目次

1. [現状の問題点](#現状の問題点)
2. [一貫性のあるインターフェース設計](#一貫性のあるインターフェース設計)
3. [実装例](#実装例)
4. [ファイル命名規則](#ファイル命名規則)
5. [コーディングスタイル](#コーディングスタイル)

## 現状の問題点

現在の実装には以下の問題があります：

1. **ファイル名の不一致**:
   - `fizbuzz.rb`と`fizbuzz.c`（zがひとつ）
   - `fizzbuzz.go`と`fizzbuzz.rs`（zzが二つ）

2. **インターフェースの不一致**:
   - Ruby, Go, C: 1-100の範囲で固定
   - Rust: コマンドライン引数を使用

3. **出力方法の違い**:
   - Ruby, C, Go: 1-100の全数値を自動出力
   - Rust: 単一の数値のFizzBuzz結果のみ出力

4. **関数分離レベルの違い**:
   - Go: メインロジックを関数として分離
   - 他の言語: モノリシックな実装

## 一貫性のあるインターフェース設計

以下の原則に従ってすべての言語実装を統一することを提案します：

1. **基本機能**:
   - `fizzbuzz(n)` 関数: 単一の数値に対するFizzBuzz変換を行う
   - `fizzbuzz_range(start, end)` 関数: 指定した範囲のFizzBuzzを実行

2. **コマンドラインインターフェース**:
   - 引数なし: 1-100のFizzBuzzを出力（デフォルト動作）
   - 単一引数: 1-N範囲のFizzBuzzを出力
   - 複数引数: Start-End範囲のFizzBuzzを出力

3. **モジュール化**:
   - ロジックとI/O処理の分離
   - テスト可能な設計

## 実装例

各言語での推奨実装パターンを以下に示します：

### Ruby

```ruby
#!/usr/bin/env ruby

# 単一数値のFizzBuzz変換
def fizzbuzz(n)
  return "FizzBuzz" if (n % 15).zero?
  return "Fizz" if (n % 3).zero?
  return "Buzz" if (n % 5).zero?
  n.to_s
end

# 範囲指定のFizzBuzz
def fizzbuzz_range(start, stop)
  (start..stop).each do |i|
    puts fizzbuzz(i)
  end
end

# コマンドライン処理
if __FILE__ == $PROGRAM_NAME
  case ARGV.size
  when 0
    # デフォルト: 1-100
    fizzbuzz_range(1, 100)
  when 1
    # 1-N範囲
    stop = ARGV[0].to_i
    fizzbuzz_range(1, stop)
  when 2
    # Start-End範囲
    start = ARGV[0].to_i
    stop = ARGV[1].to_i
    fizzbuzz_range(start, stop)
  else
    puts "Usage: #{$PROGRAM_NAME} [stop] [start stop]"
    exit 1
  end
end
```

### Go

```go
package main

import (
	"fmt"
	"os"
	"strconv"
)

// Fizzbuzz は単一の数値に対するFizzBuzz変換を行います
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

// FizzbuzzRange は指定範囲のFizzBuzzを出力します
func FizzbuzzRange(start, end int) {
	for i := start; i <= end; i++ {
		fmt.Println(Fizzbuzz(i))
	}
}

func main() {
	switch len(os.Args) {
	case 1:
		// デフォルト: 1-100
		FizzbuzzRange(1, 100)
	case 2:
		// 1-N範囲
		end, err := strconv.Atoi(os.Args[1])
		if err != nil {
			fmt.Fprintf(os.Stderr, "Invalid number: %v\n", err)
			os.Exit(1)
		}
		FizzbuzzRange(1, end)
	case 3:
		// Start-End範囲
		start, err := strconv.Atoi(os.Args[1])
		if err != nil {
			fmt.Fprintf(os.Stderr, "Invalid start number: %v\n", err)
			os.Exit(1)
		}
		end, err := strconv.Atoi(os.Args[2])
		if err != nil {
			fmt.Fprintf(os.Stderr, "Invalid end number: %v\n", err)
			os.Exit(1)
		}
		FizzbuzzRange(start, end)
	default:
		fmt.Fprintf(os.Stderr, "Usage: %s [end] [start end]\n", os.Args[0])
		os.Exit(1)
	}
}
```

### C

```c
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// 単一数値のFizzBuzz出力
void print_fizzbuzz(int n) {
    if (n % 15 == 0) {
        printf("FizzBuzz\n");
    } else if (n % 3 == 0) {
        printf("Fizz\n");
    } else if (n % 5 == 0) {
        printf("Buzz\n");
    } else {
        printf("%d\n", n);
    }
}

// 範囲指定のFizzBuzz出力
void fizzbuzz_range(int start, int end) {
    for (int i = start; i <= end; i++) {
        print_fizzbuzz(i);
    }
}

int main(int argc, char *argv[]) {
    int start = 1;
    int end = 100;

    switch (argc) {
        case 1:
            // デフォルト: 1-100
            break;
        case 2:
            // 1-N範囲
            end = atoi(argv[1]);
            break;
        case 3:
            // Start-End範囲
            start = atoi(argv[1]);
            end = atoi(argv[2]);
            break;
        default:
            printf("Usage: %s [end] [start end]\n", argv[0]);
            return 1;
    }

    fizzbuzz_range(start, end);
    return 0;
}
```

### Rust

```rust
fn fizzbuzz(n: i32) -> String {
    match (n % 3, n % 5) {
        (0, 0) => String::from("FizzBuzz"),
        (0, _) => String::from("Fizz"),
        (_, 0) => String::from("Buzz"),
        (_, _) => n.to_string(),
    }
}

fn fizzbuzz_range(start: i32, end: i32) {
    for i in start..=end {
        println!("{}", fizzbuzz(i));
    }
}

fn main() {
    let args: Vec<String> = std::env::args().collect();
    
    match args.len() {
        1 => {
            // デフォルト: 1-100
            fizzbuzz_range(1, 100);
        }
        2 => {
            // 1-N範囲
            let end = args[1].parse().unwrap_or_else(|_| {
                eprintln!("Please provide a valid number");
                std::process::exit(1);
            });
            fizzbuzz_range(1, end);
        }
        3 => {
            // Start-End範囲
            let start = args[1].parse().unwrap_or_else(|_| {
                eprintln!("Please provide a valid start number");
                std::process::exit(1);
            });
            let end = args[2].parse().unwrap_or_else(|_| {
                eprintln!("Please provide a valid end number");
                std::process::exit(1);
            });
            fizzbuzz_range(start, end);
        }
        _ => {
            eprintln!("Usage: {} [end] [start end]", args[0]);
            std::process::exit(1);
        }
    }
}
```

## ファイル命名規則

以下の命名規則に統一することを提案します：

1. **ソースファイル**:
   - Ruby: `fizzbuzz.rb`
   - Go: `fizzbuzz.go`
   - C: `fizzbuzz.c`
   - Rust: `fizzbuzz.rs`

2. **テストファイル**:
   - Ruby: `fizzbuzz_test.rb` または `test_fizzbuzz.rb`
   - Go: `fizzbuzz_test.go`
   - C: `fizzbuzz_test.c` または `test_fizzbuzz.c`
   - Rust: テストモジュールは同一ファイル内に `mod tests` として定義

3. **ディレクトリ構造**:
   - 言語ごとにディレクトリを分ける: `src/ruby/`, `src/go/`, etc.

## コーディングスタイル

各言語のコミュニティガイドラインに従い、一貫したスタイルを適用します：

1. **Ruby**: 
   - [Ruby Style Guide](https://rubystyle.guide/)に準拠
   - 2スペースインデント
   - スネークケース命名規則

2. **Go**:
   - `go fmt`によるフォーマット
   - [Effective Go](https://golang.org/doc/effective_go)ガイドラインに準拠
   - キャメルケース命名規則

3. **C**:
   - [Linux カーネルコーディングスタイル](https://www.kernel.org/doc/html/v4.10/process/coding-style.html)か[GNU スタイル](https://www.gnu.org/prep/standards/standards.html)のいずれかに準拠
   - 4スペースまたはタブインデント（一貫した使用）
   - スネークケース命名規則

4. **Rust**:
   - `cargo fmt`によるフォーマット
   - [Rust Style Guide](https://doc.rust-lang.org/1.0.0/style/README.html)に準拠
   - スネークケース命名規則

---

上記の提案を段階的に実装することで、コードベースの一貫性が大幅に向上し、将来の保守と拡張が容易になります。