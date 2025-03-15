# CI/CDパイプライン改善提案

## 概要

このドキュメントでは、マルチ言語FizzBuzzプロジェクト用のCI/CDパイプライン導入を提案します。CI/CD（継続的インテグレーション/継続的デリバリー）パイプラインを導入することで、コード品質の向上、バグの早期発見、開発ワークフローの効率化を実現します。

## 目次

1. [現状と課題](#現状と課題)
2. [CI/CDの目標](#cicdの目標)
3. [提案するワークフロー](#提案するワークフロー)
4. [GitHub Actions設定例](#github-actions設定例)
5. [導入ステップ](#導入ステップ)
6. [メリット](#メリット)

## 現状と課題

現在のプロジェクトには以下の課題があります：

- 自動テスト実行の仕組みがない
- コード品質チェックが手動
- 複数言語の構成でビルド・テストが複雑
- リポジトリにプッシュされたコードの検証が不十分

## CI/CDの目標

1. **コード品質の自動検証**: 各言語におけるコード品質チェックを自動化
2. **テストの自動実行**: すべての言語実装のテストを自動実行
3. **一貫したビルドプロセス**: 異なる環境でも同じ結果となるビルドプロセスの確立
4. **問題の早期検出**: プッシュやPR作成時に問題をすぐに検出する

## 提案するワークフロー

以下のタイミングでCI/CDパイプラインを実行します：

1. **Pull Request作成時**: コード品質チェック、ビルド、テスト
2. **main/masterブランチへのプッシュ時**: 完全なビルド・テストサイクル

## GitHub Actions設定例

以下に、GitHub Actionsを使用したCI/CD設定の例を示します：

### 1. 基本的なビルド・テストワークフロー

```yaml
# .github/workflows/build-test.yml
name: Build and Test

on:
  push:
    branches: [ main ]
  pull_request:
    branches: [ main ]

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v3
    
    # 環境セットアップ
    - name: Set up Ruby
      uses: ruby/setup-ruby@v1
      with:
        ruby-version: '3.2'
    
    - name: Set up Go
      uses: actions/setup-go@v4
      with:
        go-version: '1.21'
    
    - name: Set up Rust
      uses: actions-rs/toolchain@v1
      with:
        toolchain: stable
    
    - name: Install dependencies
      run: |
        sudo apt-get update
        sudo apt-get install -y gcc
    
    # ビルドとテスト
    - name: Build all implementations
      run: make all
    
    - name: Run tests
      run: make test
```

### 2. コード品質チェックワークフロー

```yaml
# .github/workflows/code-quality.yml
name: Code Quality

on:
  push:
    branches: [ main ]
  pull_request:
    branches: [ main ]

jobs:
  lint:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v3
    
    # Rubyのリント
    - name: Set up Ruby
      uses: ruby/setup-ruby@v1
      with:
        ruby-version: '3.2'
    
    - name: Ruby Lint
      run: |
        gem install rubocop
        rubocop src/ruby/
    
    # Goのリント
    - name: Set up Go
      uses: actions/setup-go@v4
      with:
        go-version: '1.21'
    
    - name: Go Lint
      run: |
        go install golang.org/x/lint/golint@latest
        golint src/go/
    
    # Rustのリント
    - name: Set up Rust
      uses: actions-rs/toolchain@v1
      with:
        toolchain: stable
        components: clippy
    
    - name: Rust Lint
      run: |
        cd src/rust/
        cargo clippy -- -D warnings
    
    # Cのリント
    - name: C Lint
      run: |
        sudo apt-get update
        sudo apt-get install -y cppcheck
        cppcheck src/c/
```

### 3. 言語ごとの特化ワークフロー（オプション）

必要に応じて、言語ごとに特化したテストやタスクを実行するワークフローも導入できます。例えば：

```yaml
# .github/workflows/rust-checks.yml
name: Rust Specific Checks

on:
  push:
    paths:
      - 'src/rust/**'
  pull_request:
    paths:
      - 'src/rust/**'

jobs:
  rust-specific:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v3
    
    - name: Set up Rust
      uses: actions-rs/toolchain@v1
      with:
        toolchain: stable
        components: rustfmt, clippy
    
    - name: Format check
      run: |
        cd src/rust/
        cargo fmt -- --check
    
    - name: Clippy
      run: |
        cd src/rust/
        cargo clippy -- -D warnings
    
    - name: Run tests
      run: |
        cd src/rust/
        cargo test
```

## 導入ステップ

1. **プロジェクト構造のリファクタリング**:
   - ソースコードを`src/`ディレクトリに移動
   - 言語ごとにディレクトリ分け

2. **テストの拡充**:
   - すべての言語にテストを追加
   - `make test`コマンドが全言語のテストを実行するよう修正

3. **CI設定ファイルの作成**:
   - `.github/workflows/`ディレクトリの作成
   - 上記のYAMLファイルを配置

4. **Makefileの修正**:
   - 新しいディレクトリ構造に対応
   - 言語ごとのリントコマンドを追加

5. **ドキュメントの更新**:
   - READMEに CI/CDについての説明を追加
   - 貢献ガイドラインにCI通過の要件を記載

## メリット

1. **品質向上**: 一貫したコード品質の維持
2. **早期フィードバック**: 問題の早期発見と修正
3. **コラボレーション促進**: 安全にコードを共同開発可能
4. **ドキュメント化**: ビルドとテストのプロセスが明文化

---

このドキュメントは提案であり、プロジェクトのニーズに合わせて調整できます。特に使用言語や開発フローに応じて、CI/CDパイプラインの内容は柔軟に変更可能です。