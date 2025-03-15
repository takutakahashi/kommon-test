# マルチ言語 FizzBuzz 実装

このリポジトリは、複数のプログラミング言語（Ruby、Go、C、Rust）でFizzBuzzを実装したものです。各言語の特性を生かした実装を比較することができます。

## FizzBuzz とは

FizzBuzzは、プログラミングの基礎を学ぶための一般的な問題です。

- 1から特定の数まで数えていく
- 3の倍数のときは「Fizz」と出力
- 5の倍数のときは「Buzz」と出力
- 3と5の両方の倍数（15の倍数）のときは「FizzBuzz」と出力
- それ以外の数値はそのまま出力

## 対応言語

現在、以下の言語に対応しています：

- Ruby
- Go
- C
- Rust

## 使い方

### 全言語実行

```bash
make all
```

### 特定の言語で実行

```bash
# Ruby実装を実行
make ruby

# Go実装を実行
make go

# C実装を実行
make c

# Rust実装を実行
make rust
```

### テスト実行

```bash
make test
```

### クリーンアップ

```bash
make clean
```

## 各言語実装の特徴

### Ruby

シンプルで読みやすい実装です。1から100までの数値に対してFizzBuzzを実行します。

```ruby
def fizzbuzz(n)
  (1..n).each do |i|
    if i % 15 == 0
      puts "FizzBuzz"
    elsif i % 3 == 0
      puts "Fizz"
    elsif i % 5 == 0
      puts "Buzz"
    else
      puts i
    end
  end
end
```

### Go

関数型のアプローチで実装されています。FizzBuzzのロジックとメイン処理が分離されており、テストが書かれています。

```go
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
```

### C

標準的なC言語によるシンプルな実装です。

```c
for (int i = 1; i <= 100; i++) {
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
```

### Rust

パターンマッチングを利用した実装です。コマンドライン引数を受け取って特定の数値に対するFizzBuzzを計算します。

```rust
fn fizzbuzz(n: i32) -> String {
  match (n % 3, n % 5) {
    (0, 0) => String::from("FizzBuzz"),
    (0, _) => String::from("Fizz"),
    (_, 0) => String::from("Buzz"),
    (_, _) => n.to_string(),
  }
}
```

## 今後の改善予定

詳細な改善案は [improvement-proposals.md](docs/improvement-proposals.md) を参照してください。主なポイントは：

1. ディレクトリ構造の整理
2. すべての言語での一貫した実装
3. テストの拡充
4. CI/CDパイプラインの導入
5. ドキュメントの充実

## ライセンス

このプロジェクトは [MITライセンス](LICENSE) の下で公開されています。

## 貢献

バグ報告や機能リクエスト、プルリクエストは大歓迎です！