# マルチ言語FizzBuzzコレクション

## 概要

このリポジトリは、様々なプログラミング言語によるFizzBuzzの実装コレクションです。FizzBuzzは、プログラミングの基本を学ぶ際の典型的な練習問題で、以下のルールに従います：

- 1からNまでの数字を順番に出力する
- 3の倍数のときは数字の代わりに「Fizz」と出力
- 5の倍数のときは数字の代わりに「Buzz」と出力
- 3と5の両方の倍数（つまり15の倍数）のときは「FizzBuzz」と出力

## サポートされている言語

- Go
- Ruby
- Python
- C
- Rust

## 使い方

各言語の実装は、コマンドライン引数で出力する数の上限（N）を指定できます。引数を省略した場合は、デフォルトで1から100までの数値に対してFizzBuzzを実行します。

### 実行例

```bash
# Ruby版の実行（1から15までの出力）
ruby fizbuzz.rb 15

# Go版の実行（1から15までの出力）
go run fizzbuzz.go 15

# Python版の実行（1から15までの出力）
python fizzbuzz.py 15

# C版の実行（1から15までの出力）
gcc -o fizbuzz fizbuzz.c
./fizbuzz 15

# Rust版の実行（1から15までの出力）
rustc fizzbuzz.rs
./fizzbuzz 15
```

## Makefileを使った実行

このリポジトリにはMakefileが含まれており、以下のコマンドで各言語の実装を一括で実行できます：

```bash
# すべての言語の実装を実行（デフォルトで1〜15までを出力）
make all

# 特定の言語の実装だけを実行
make ruby
make go
make c
make rust
make python

# テストの実行
make test

# コンパイルした実行ファイルを削除
make clean
```

## テスト

Go版とPython版には単体テストが実装されています。以下のコマンドでテストを実行できます：

```bash
# Goのテスト
go test fizzbuzz_test.go fizzbuzz.go

# Pythonのテスト
python -m unittest test_fizzbuzz.py
```

## 貢献

新しい言語でのFizzBuzzの実装や、既存実装の改善など、どんな貢献でも歓迎します。