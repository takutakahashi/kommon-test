# Git と GitHub の活用

このドキュメントでは、Git と GitHub を効果的に使用するためのベストプラクティス、ワークフロー、および学んだテクニックについてまとめています。

## Git の基本概念

### リポジトリの構造

Git リポジトリは以下の主要な部分から構成されています：

- **ワーキングディレクトリ**: 現在作業している場所
- **ステージングエリア（インデックス）**: コミット準備ができたファイルを追加する場所
- **ローカルリポジトリ**: コミットされた履歴が保存される場所
- **リモートリポジトリ**: 共有用の中央リポジトリ（例：GitHub上）

### 基本コマンド

```bash
# リポジトリの初期化
git init

# ファイルをステージングエリアに追加
git add <ファイル名>
git add .  # すべての変更をステージング

# 変更をコミット
git commit -m "コミットメッセージ"

# リモートリポジトリを追加
git remote add origin <リポジトリURL>

# 変更をプッシュ
git push origin <ブランチ名>

# リモートの変更を取得
git pull origin <ブランチ名>

# ブランチを作成して切り替え
git checkout -b <新しいブランチ名>

# ブランチの切り替え
git checkout <ブランチ名>

# ブランチの一覧表示
git branch

# リモートブランチの一覧表示
git branch -r

# 変更状態の確認
git status

# コミット履歴の確認
git log
git log --oneline --graph --decorate  # グラフィカル表示
```

## 効果的なブランチ戦略

### Gitflow ワークフロー

Gitflow は、特にリリースサイクルが明確なプロジェクトに適したブランチ戦略です。

#### 主要ブランチ

- **main/master**: 本番環境用コード（常に安定している）
- **develop**: 開発中のコード（次のリリース準備用）

#### サポートブランチ

- **feature/\***: 新機能開発（developから分岐、developにマージ）
- **release/\***: リリース準備（developから分岐、main/masterとdevelopにマージ）
- **hotfix/\***: 緊急バグ修正（main/masterから分岐、main/masterとdevelopにマージ）

```bash
# feature ブランチの作成
git checkout develop
git checkout -b feature/new-awesome-feature

# 作業完了後、develop にマージ
git checkout develop
git merge feature/new-awesome-feature
```

### GitHub Flow

GitHub Flow はより単純なワークフローで、継続的デプロイメントに適しています。

1. **main/master** ブランチからトピックブランチを作成
2. 変更を加え、コミット
3. GitHub にプッシュしてプルリクエストを作成
4. レビュー、議論、フィードバック
5. main/master にマージ
6. デプロイ

```bash
# トピックブランチの作成
git checkout main
git checkout -b fix-login-issue

# 作業後、プッシュとプルリクエスト作成
git push origin fix-login-issue
# GitHub上でPRを作成
```

## コミットメッセージのベストプラクティス

### 構造化コミットメッセージ

Conventional Commits の形式を使用すると、コミット履歴が整理され、セマンティックバージョニングの自動化が容易になります。

```
<type>[optional scope]: <description>

[optional body]

[optional footer(s)]
```

#### タイプの例

- **feat**: 新機能の追加
- **fix**: バグ修正
- **docs**: ドキュメント変更のみ
- **style**: コードの意味に影響しない変更（フォーマット等）
- **refactor**: バグ修正や機能追加ではないコード変更
- **test**: テストの追加や修正
- **chore**: ビルドプロセスや補助ツールの変更

#### 例

```
feat(auth): implement OAuth2 login system

- Add OAuth2 client integration
- Create login and callback handlers
- Update user service to handle OAuth identities

Closes #42
```

## プルリクエストとコードレビュー

### 効果的なプルリクエスト

#### プルリクエストの作成

1. **明確なタイトルと説明**:
   ```
   タイトル: [機能] ユーザー認証システムの実装
   
   説明:
   このPRでは、JWT を使用したユーザー認証システムを実装しています。
   
   変更内容:
   - ユーザー登録エンドポイントの追加
   - ログイン機能の実装
   - JWT の生成と検証ロジックの追加
   - ミドルウェアによる認証済みルートの保護
   
   関連Issue: #123
   ```

2. **適切な粒度**: 
   - 1つのPRで1つの論理的な変更/機能に集中
   - 大きな機能は複数の小さなPRに分割

3. **セルフレビュー**:
   - PRを提出前に自分で一度レビュー
   - 不要なログやコメントの削除
   - コードスタイルの一貫性確認

### コードレビューのプラクティス

#### レビュアーとして

1. **コードの理解**:
   - コードの目的と文脈を把握
   - 設計の意図を理解する

2. **建設的なフィードバック**:
   - 問題点だけでなく良い点も指摘
   - 「なぜ」を説明する
   ```
   この条件分岐は複雑になっています。可読性を高めるため、この部分を別の関数に抽出することを検討してみてはどうでしょうか？
   ```

3. **優先順位付け**:
   - ブロッカーとなる問題と単なる提案を区別
   ```
   [ブロッカー] この部分にセキュリティ脆弱性があります：...
   [提案] この関数名をより説明的なものに変更するといいかもしれません
   ```

#### 被レビュー者として

1. **レビューコメントに丁寧に対応**
2. **変更理由を説明**
3. **フィードバックを個人的に受け取らない**

## Git 高度なテクニック

### リベース vs マージ

#### マージ

```bash
git checkout feature
git merge master  # master の変更を feature にマージ
```

- **特徴**: 履歴を保持し、マージコミットが作成される
- **適切な状況**: 共有ブランチへの統合

#### リベース

```bash
git checkout feature
git rebase master  # feature を master の先端に移動
```

- **特徴**: 履歴が線形になり、マージコミットが作成されない
- **適切な状況**: 公開前のローカルブランチの整理

### コミットの整理

#### コミットの修正

```bash
git commit --amend  # 直前のコミットを修正
```

#### インタラクティブリベース

```bash
git rebase -i HEAD~3  # 直近3コミットを対象に整理
```

主要なオプション:
- `pick`: コミットを使用
- `reword`: コミットメッセージを変更
- `edit`: コミット内容を変更
- `squash`: 前のコミットに統合（メッセージ編集可）
- `fixup`: 前のコミットに統合（メッセージ破棄）
- `drop`: コミットを削除

### スタッシュ

作業中の変更を一時的に保存する機能:

```bash
# 変更を保存
git stash

# 保存したスタッシュ一覧を表示
git stash list

# スタッシュを適用して削除
git stash pop

# スタッシュを適用して保持
git stash apply

# 特定のスタッシュを適用
git stash apply stash@{2}

# スタッシュを破棄
git stash drop stash@{0}

# すべてのスタッシュをクリア
git stash clear
```

### git-bisect による問題のデバッグ

バグが導入されたコミットを見つけるための二分探索:

```bash
# bisect開始
git bisect start

# 既知の「悪い」コミット
git bisect bad

# 既知の「良い」コミット
git bisect good <コミットハッシュ>

# テスト後、現在のコミットを判定
git bisect good  # または
git bisect bad

# 完了後、元の状態に戻る
git bisect reset
```

## GitHub の高度な機能

### GitHub Actions

GitHub Actions は、リポジトリ内でのイベントをトリガーに自動化ワークフローを実行する機能です。

#### ワークフローの例（Node.jsアプリのCI）

```yaml
name: Node.js CI

on:
  push:
    branches: [ main, develop ]
  pull_request:
    branches: [ main, develop ]

jobs:
  test:
    runs-on: ubuntu-latest
    
    strategy:
      matrix:
        node-version: [14.x, 16.x, 18.x]
    
    steps:
    - uses: actions/checkout@v3
    - name: Use Node.js ${{ matrix.node-version }}
      uses: actions/setup-node@v3
      with:
        node-version: ${{ matrix.node-version }}
        cache: 'npm'
    - run: npm ci
    - run: npm test
```

### Issue テンプレート

リポジトリの `.github/ISSUE_TEMPLATE/` ディレクトリに配置して、Issue 作成時のテンプレートを提供できます。

#### バグレポートテンプレートの例

```markdown
---
name: バグレポート
about: アプリの不具合を報告
title: '[BUG] '
labels: bug
assignees: ''
---

## 発生している問題
明確かつ簡潔に問題を記述してください。

## 再現手順
動作を再現する手順:
1. '...' に移動
2. '....' をクリック
3. '....' までスクロール
4. エラーを確認

## 期待される動作
何が起こることを期待していたのか明確に記述してください。

## スクリーンショット
該当する場合、問題の説明に役立つスクリーンショットを追加してください。

## 環境情報
 - OS: [例: iOS, Windows 10]
 - ブラウザ: [例: Chrome, Safari]
 - バージョン: [例: 22]

## その他の情報
ここに問題に関するその他の情報を追加してください。
```

### プルリクエストテンプレート

リポジトリのルートまたは `.github/` ディレクトリに `PULL_REQUEST_TEMPLATE.md` ファイルを配置します。

```markdown
## 変更の種類
- [ ] バグ修正
- [ ] 新機能
- [ ] 破壊的変更
- [ ] パフォーマンス改善
- [ ] ドキュメント更新

## 変更内容
このプルリクエストで何が変更されるのかを明確に記述してください。

## 関連 Issue
このプルリクエストが関連するIssueを記述してください。

## テスト
どのようにこの変更をテストしたかを記述してください。

## スクリーンショット（必要な場合）

## チェックリスト
- [ ] コードスタイルに準拠している
- [ ] すべてのテストが成功している
- [ ] ドキュメントを更新した（必要な場合）
- [ ] 関連するIssueを参照している
```

### GitHub プロジェクト

GitHub Projectsはタスクとワークフローを管理するためのかんばんボードスタイルのツールです。

#### 効果的な使用方法

1. **列の設定**:
   - ToDo
   - In Progress
   - Review
   - Done

2. **Issue とプルリクエストの統合**
3. **オートメーションの使用**:
   - PRがマージされたら自動的にIssueをクローズ
   - ラベルに基づいて自動的に優先度を設定

## セキュリティのベストプラクティス

### 機密情報の保護

- **シークレットとトークンを絶対にコミットしない**
- **環境変数と GitHub シークレットを使用する**
- **.gitignore を適切に設定する**

### GitHub セキュリティ機能

- **Dependabot アラート**: 脆弱性のある依存関係を検出
- **コードスキャン**: コード内のセキュリティ問題を特定
- **シークレットスキャン**:  コミット内の誤って含まれたシークレットを検出

## まとめ

Git と GitHub は現代のソフトウェア開発において不可欠なツールです。適切なワークフローとプラクティスを採用することで、チームの効率とコード品質を向上させることができます。このドキュメントで紹介した技法を日々の開発に取り入れることで、より組織的で生産的な開発プロセスを実現できるでしょう。