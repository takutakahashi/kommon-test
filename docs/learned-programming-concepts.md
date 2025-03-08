# 学習した主要なプログラミングコンセプト

## 1. FizzBuzzプログラミング

FizzBuzzは、プログラミングの基本的な概念を学ぶための代表的な課題です。このリポジトリでは、複数の言語による実装を通じて、以下の概念を学びました。

### 条件分岐（Conditional Logic）

すべての実装において、数値の性質に応じて異なる出力を生成するための条件分岐が使用されています。

- **if/elseステートメント**: C言語、Ruby、Goでの基本的な条件分岐
- **match式**: Rustでのパターンマッチング

### モジュラー演算（Modulo Operation）

FizzBuzzの核となるロジックは、数値を3および5で割った余り（modulo演算）に基づいています。各言語で`%`演算子を使用して実装されています。

### 型変換（Type Conversion）

数値を文字列に変換する方法が言語によって異なります：
- Go: `strconv.Itoa()`関数
- Rust: `.to_string()`メソッド
- Ruby: 暗黙的な変換
- C: `printf()`関数での書式指定

### 反復処理（Iteration）

1から100までの数を処理するための反復処理：
- Go、C: `for`ループ
- Ruby: 範囲オブジェクト(`Range`)と`each`メソッド
- Rust: コマンドライン引数として与えられた単一の値を処理

### 関数定義（Function Definition）

言語間での関数/メソッドの定義方法の違い：
- Go: `func Fizzbuzz(n int) string { ... }`
- Ruby: `def fizzbuzz(n) ... end`
- Rust: `fn fizzbuzz(n: i32) -> String { ... }`

### コマンドライン引数処理（Command-line Arguments）

Rustでは、コマンドライン引数を処理して入力値を取得する方法を示しています：
```rust
let args: Vec<String> = std::env::args().collect();
if args.len() != 2 {
    // エラー処理
}
let n: i32 = args[1].parse().unwrap_or_else(|_| {
    // パース失敗時の処理
});
```

## 2. テスト駆動開発（TDD）

Goでの`fizzbuzz_test.go`ファイルは、テスト駆動開発の概念を示しています：

### テストケース定義

```go
tests := []struct {
    input    int
    expected string
}{
    {1, "1"},
    {2, "2"},
    {3, "Fizz"},
    // 他のテストケース
}
```

### テスト実行と検証

各テストケースに対して関数を実行し、結果を検証する方法：

```go
for _, test := range tests {
    result := Fizzbuzz(test.input)
    if result != test.expected {
        t.Errorf("Fizzbuzz(%d) = %s; want %s", test.input, result, test.expected)
    }
}
```

## 3. ビルドシステムとMakefile

Makefileを通じて、異なる言語のコンパイルと実行を自動化する方法を学びました：

### ターゲットとルール

```make
.PHONY: all clean ruby go c rust test

all: ruby go c rust

ruby:
    ruby fizbuzz.rb
```

### 依存関係管理

```make
fizbuzz: fizbuzz.c
    gcc -o fizbuzz fizbuzz.c
```

### クリーンアップ

```make
clean:
    rm -f fizbuzz fizzbuzz
```

## 4. 言語間の比較と対照

このリポジトリでは、同じFizzBuzz問題を4つの異なる言語で実装しています。これにより、以下のような言語間の比較学習ができました：

### 言語の表現力

- Rust: パターンマッチングを使用した簡潔なソリューション
- Ruby: 動的型付け言語の柔軟性
- Go: 静的型付けと明示的なエラー処理
- C: 低レベルの制御とメモリ管理

### 実行環境の違い

- コンパイル言語 (Go, C, Rust)
- インタープリタ言語 (Ruby)

### エラー処理

- Rustの`Result`型と`unwrap_or_else`パターン
- その他の言語での単純なエラー出力

## 5. セマンティクスとシンタックス

各言語特有の構文と意味論：

### Go
- 明示的な型宣言
- エクスポートはキャピタルケースで制御
- 組み込みの型変換関数

### Ruby
- 動的型付け
- シンボルや範囲などの高レベル構造
- ブロックとイテレータ

### C
- 明示的メモリ管理
- フォーマット文字列による入出力
- 命令型プログラミングスタイル

### Rust
- 所有権と借用の概念
- パターンマッチング
- 結果型を使用した堅牢なエラー処理

## 結論

このリポジトリを通じて、同じ問題に対する多様なアプローチを学び、各言語の強みと弱み、そしてプログラミングパラダイムの違いを理解することができました。これらの知識は、新しい言語を学ぶ際の基盤となり、より複雑な問題に取り組む際の判断力を養うのに役立ちます。