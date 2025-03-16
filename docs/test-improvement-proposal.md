# テスト拡充提案

## 概要

本ドキュメントでは、FizzBuzzの複数言語実装における体系的なテスト戦略を提案します。現在、テストはGoの実装にのみ存在し、他言語には存在しないか不十分です。適切なテストは品質確保の基盤であり、将来の機能拡張やリファクタリングの際の安全性を高めます。

## 目次

1. [現状と課題](#現状と課題)
2. [推奨するテストアプローチ](#推奨するテストアプローチ)
3. [各言語でのテスト実装例](#各言語でのテスト実装例)
4. [テストカバレッジ](#テストカバレッジ)
5. [CI/CDとの統合](#cicdとの統合)

## 現状と課題

現状のテスト状況は以下の通りです：

- **Go**: テストファイル(`fizzbuzz_test.go`)が存在し、基本的なテストが実装されている
- **Ruby**, **C**, **Rust**: テストが存在しない

これにより、以下の課題が生じています：

1. 機能の正確性を検証する手段が不十分
2. リファクタリング時の安全性が担保されていない
3. 新規機能追加時の回帰テストがない

## 推奨するテストアプローチ

各言語の実装に対して、以下のテスト戦略を採用することを提案します：

1. **単体テスト**:
   - 基本的なFizzBuzz変換ロジックのテスト
   - エッジケース（0、負の数、大きな数値）のテスト
   - カスタマイズされたFizzBuzzルール（将来的な機能）のテスト

2. **テストカバレッジ**:
   - 各言語のカバレッジツールを使用
   - 目標カバレッジ率: 90%以上

3. **テスト自動化**:
   - `make test`コマンドで全言語のテストを実行
   - CI/CDパイプラインと統合

## 各言語でのテスト実装例

### Ruby

```ruby
# test_fizzbuzz.rb
require 'minitest/autorun'
require_relative 'fizzbuzz'

class FizzbuzzTest < Minitest::Test
  def test_returns_number_for_non_multiples
    assert_equal "1", fizzbuzz(1)
    assert_equal "2", fizzbuzz(2)
    assert_equal "4", fizzbuzz(4)
  end

  def test_returns_fizz_for_multiples_of_three
    assert_equal "Fizz", fizzbuzz(3)
    assert_equal "Fizz", fizzbuzz(6)
    assert_equal "Fizz", fizzbuzz(9)
  end

  def test_returns_buzz_for_multiples_of_five
    assert_equal "Buzz", fizzbuzz(5)
    assert_equal "Buzz", fizzbuzz(10)
    assert_equal "Buzz", fizzbuzz(20)
  end

  def test_returns_fizzbuzz_for_multiples_of_fifteen
    assert_equal "FizzBuzz", fizzbuzz(15)
    assert_equal "FizzBuzz", fizzbuzz(30)
    assert_equal "FizzBuzz", fizzbuzz(45)
  end

  def test_handles_zero
    assert_equal "FizzBuzz", fizzbuzz(0)
  end

  def test_handles_negative_numbers
    assert_equal "Fizz", fizzbuzz(-3)
    assert_equal "Buzz", fizzbuzz(-5)
    assert_equal "FizzBuzz", fizzbuzz(-15)
  end
end
```

### Go

現在のGoのテストは良好ですが、以下のように拡張することを提案します：

```go
package main

import (
	"testing"
)

func TestFizzbuzz(t *testing.T) {
	tests := []struct {
		name     string
		input    int
		expected string
	}{
		{"Regular number", 1, "1"},
		{"Regular number", 2, "2"},
		{"Multiple of 3", 3, "Fizz"},
		{"Regular number", 4, "4"},
		{"Multiple of 5", 5, "Buzz"},
		{"Multiple of 3", 6, "Fizz"},
		{"Multiple of 5", 10, "Buzz"},
		{"Multiple of 3 and 5", 15, "FizzBuzz"},
		{"Multiple of 3 and 5", 30, "FizzBuzz"},
		{"Zero", 0, "FizzBuzz"},
		{"Negative multiple of 3", -3, "Fizz"},
		{"Negative multiple of 5", -5, "Buzz"},
		{"Negative multiple of 15", -15, "FizzBuzz"},
	}

	for _, test := range tests {
		t.Run(test.name, func(t *testing.T) {
			result := Fizzbuzz(test.input)
			if result != test.expected {
				t.Errorf("Fizzbuzz(%d) = %s; want %s", test.input, result, test.expected)
			}
		})
	}
}

func TestFizzbuzzRange(t *testing.T) {
	// This test would verify that the range function works correctly
	// But since it's an output function, we'd need to capture stdout
	// This is an example of how you might structure it
	// Actual implementation would depend on how we refactor the code
	t.Run("Range function works", func(t *testing.T) {
		// Mock stdout and verify output
		// Or refactor to return a slice and test that
	})
}
```

### C

```c
// test_fizzbuzz.c
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <assert.h>

// Include the functions to test
// This assumes we've refactored the C code to expose testable functions
#include "fizzbuzz.h"

void test_fizzbuzz_number() {
    char buffer[20];
    
    get_fizzbuzz(1, buffer);
    assert(strcmp(buffer, "1") == 0);
    
    get_fizzbuzz(2, buffer);
    assert(strcmp(buffer, "2") == 0);
    
    get_fizzbuzz(4, buffer);
    assert(strcmp(buffer, "4") == 0);
    
    printf("✓ Test fizzbuzz number: passed\n");
}

void test_fizzbuzz_fizz() {
    char buffer[20];
    
    get_fizzbuzz(3, buffer);
    assert(strcmp(buffer, "Fizz") == 0);
    
    get_fizzbuzz(6, buffer);
    assert(strcmp(buffer, "Fizz") == 0);
    
    get_fizzbuzz(9, buffer);
    assert(strcmp(buffer, "Fizz") == 0);
    
    printf("✓ Test fizzbuzz fizz: passed\n");
}

void test_fizzbuzz_buzz() {
    char buffer[20];
    
    get_fizzbuzz(5, buffer);
    assert(strcmp(buffer, "Buzz") == 0);
    
    get_fizzbuzz(10, buffer);
    assert(strcmp(buffer, "Buzz") == 0);
    
    get_fizzbuzz(20, buffer);
    assert(strcmp(buffer, "Buzz") == 0);
    
    printf("✓ Test fizzbuzz buzz: passed\n");
}

void test_fizzbuzz_fizzbuzz() {
    char buffer[20];
    
    get_fizzbuzz(15, buffer);
    assert(strcmp(buffer, "FizzBuzz") == 0);
    
    get_fizzbuzz(30, buffer);
    assert(strcmp(buffer, "FizzBuzz") == 0);
    
    get_fizzbuzz(45, buffer);
    assert(strcmp(buffer, "FizzBuzz") == 0);
    
    printf("✓ Test fizzbuzz fizzbuzz: passed\n");
}

void test_fizzbuzz_zero() {
    char buffer[20];
    
    get_fizzbuzz(0, buffer);
    assert(strcmp(buffer, "FizzBuzz") == 0);
    
    printf("✓ Test fizzbuzz zero: passed\n");
}

void test_fizzbuzz_negative() {
    char buffer[20];
    
    get_fizzbuzz(-3, buffer);
    assert(strcmp(buffer, "Fizz") == 0);
    
    get_fizzbuzz(-5, buffer);
    assert(strcmp(buffer, "Buzz") == 0);
    
    get_fizzbuzz(-15, buffer);
    assert(strcmp(buffer, "FizzBuzz") == 0);
    
    printf("✓ Test fizzbuzz negative: passed\n");
}

int main() {
    printf("Running fizzbuzz tests...\n");
    
    test_fizzbuzz_number();
    test_fizzbuzz_fizz();
    test_fizzbuzz_buzz();
    test_fizzbuzz_fizzbuzz();
    test_fizzbuzz_zero();
    test_fizzbuzz_negative();
    
    printf("All tests passed!\n");
    return 0;
}
```

この実装には、C言語のfizzbuzz関数を以下のように変更する必要があります：

```c
// fizzbuzz.h
#ifndef FIZZBUZZ_H
#define FIZZBUZZ_H

void get_fizzbuzz(int n, char* buffer);
void fizzbuzz_range(int start, int end);

#endif
```

```c
// fizzbuzz.c
#include <stdio.h>
#include <string.h>
#include "fizzbuzz.h"

void get_fizzbuzz(int n, char* buffer) {
    if (n % 15 == 0) {
        strcpy(buffer, "FizzBuzz");
    } else if (n % 3 == 0) {
        strcpy(buffer, "Fizz");
    } else if (n % 5 == 0) {
        strcpy(buffer, "Buzz");
    } else {
        sprintf(buffer, "%d", n);
    }
}

void fizzbuzz_range(int start, int end) {
    char buffer[20];
    for (int i = start; i <= end; i++) {
        get_fizzbuzz(i, buffer);
        printf("%s\n", buffer);
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

Rustではunittest機能を使ってテストを追加します：

```rust
// fizzbuzz.rs
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
    // ... メイン処理 ...
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_regular_numbers() {
        assert_eq!(fizzbuzz(1), "1");
        assert_eq!(fizzbuzz(2), "2");
        assert_eq!(fizzbuzz(4), "4");
    }

    #[test]
    fn test_multiples_of_three() {
        assert_eq!(fizzbuzz(3), "Fizz");
        assert_eq!(fizzbuzz(6), "Fizz");
        assert_eq!(fizzbuzz(9), "Fizz");
    }

    #[test]
    fn test_multiples_of_five() {
        assert_eq!(fizzbuzz(5), "Buzz");
        assert_eq!(fizzbuzz(10), "Buzz");
        assert_eq!(fizzbuzz(20), "Buzz");
    }

    #[test]
    fn test_multiples_of_fifteen() {
        assert_eq!(fizzbuzz(15), "FizzBuzz");
        assert_eq!(fizzbuzz(30), "FizzBuzz");
        assert_eq!(fizzbuzz(45), "FizzBuzz");
    }

    #[test]
    fn test_zero() {
        assert_eq!(fizzbuzz(0), "FizzBuzz");
    }

    #[test]
    fn test_negative_numbers() {
        assert_eq!(fizzbuzz(-3), "Fizz");
        assert_eq!(fizzbuzz(-5), "Buzz");
        assert_eq!(fizzbuzz(-15), "FizzBuzz");
    }
}
```

## テストカバレッジ

各言語でテストカバレッジを測定するためのツールを導入することを提案します：

1. **Ruby**: SimpleCov
   ```ruby
   # Gemfileに追加
   gem 'simplecov', require: false, group: :test

   # test_fizzbuzz.rb の先頭に追加
   require 'simplecov'
   SimpleCov.start
   ```

2. **Go**: built-in coverage tool
   ```bash
   go test -cover ./...
   # 詳細なカバレッジレポート
   go test -coverprofile=coverage.out ./...
   go tool cover -html=coverage.out
   ```

3. **C**: gcov
   ```bash
   gcc -fprofile-arcs -ftest-coverage fizzbuzz.c test_fizzbuzz.c -o test_fizzbuzz
   ./test_fizzbuzz
   gcov fizzbuzz.c
   ```

4. **Rust**: grcov または tarpaulin
   ```bash
   cargo install cargo-tarpaulin
   cargo tarpaulin
   ```

## CI/CDとの統合

テストは以下のようにCI/CDパイプラインに統合することを提案します：

```yaml
# .github/workflows/test.yml
name: Tests

on:
  push:
    branches: [ main ]
  pull_request:
    branches: [ main ]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v3
    
    # Ruby
    - name: Set up Ruby
      uses: ruby/setup-ruby@v1
      with:
        ruby-version: '3.2'
        bundler-cache: true
    
    - name: Run Ruby tests
      run: |
        cd src/ruby
        ruby test_fizzbuzz.rb
    
    # Go
    - name: Set up Go
      uses: actions/setup-go@v4
      with:
        go-version: '1.21'
    
    - name: Run Go tests
      run: |
        cd src/go
        go test -v -cover
    
    # C
    - name: Install C dependencies
      run: sudo apt-get install -y gcc gcovr

    - name: Run C tests
      run: |
        cd src/c
        gcc -fprofile-arcs -ftest-coverage fizzbuzz.c test_fizzbuzz.c -o test_fizzbuzz
        ./test_fizzbuzz
        gcovr
    
    # Rust
    - name: Set up Rust
      uses: actions-rs/toolchain@v1
      with:
        toolchain: stable
        override: true
    
    - name: Run Rust tests
      run: |
        cd src/rust
        cargo test
```

## 期待される効果

テスト拡充により、以下の効果が期待されます：

1. **品質向上**: バグの早期発見と修正
2. **リファクタリング容易化**: 安全なコード変更の保障
3. **機能拡張コスト低減**: 新機能追加時の回帰防止
4. **ドキュメント効果**: テストはコードの使用例としても機能

---

本提案は、プロジェクトの品質と保守性向上のための第一歩です。将来的には、プロパティベーステストやモックを用いた高度なテストなども検討できます。