# コード品質とベストプラクティス

このドキュメントでは、高品質なコードを書くための重要な原則とベストプラクティスについてまとめています。

## コードの可読性

### 命名規則

良い命名は読み手に即座に目的を伝えます：

#### 変数名

- **具体的で説明的な名前を使用する**
  - 悪い例: `a`, `temp`, `x`
  - 良い例: `userCount`, `totalPrice`, `isActive`

- **一貫した命名規則を使用する**
  - キャメルケース: `userName` (Go, JavaScriptで一般的)
  - スネークケース: `user_name` (Python, Rubyで一般的)
  - パスカルケース: `UserName` (C#, Javaのクラス名で一般的)

#### 関数/メソッド名

- **動詞から始める**
  - `calculateTotal()`, `getUserData()`, `validateInput()`

- **単一責任の原則を反映させる**
  - `parseAndValidate()`より`parse()`と`validate()`を別々に定義する方が良い

### コメント

- **なぜそうするのかを説明する**（何をしているかは通常コード自体から明らか）
  ```go
  // ユーザーIDを16進数に変換する - レガシーシステムとの互換性のため
  userIdHex := fmt.Sprintf("%x", userId)
  ```

- **複雑なアルゴリズムや非自明なコードにはドキュメンテーションコメントを付ける**
  ```go
  // ブルームフィルターの最適なビット数を計算する
  // n: 予想される最大要素数
  // p: 許容される誤検知確率
  // 戻り値: 必要なビット数
  func calculateOptimalBits(n int, p float64) int {
      // 計算ロジック
  }
  ```

### コードの構造化

- **短い関数/メソッド**
  - 理想的には20-30行以内
  - 単一の明確な目的を持つべき

- **適切な空白と字下げの使用**
  - 論理的なコードブロックを視覚的に区切る
  - 一貫した字下げスタイルを使用する（スペース vs タブ）

## コード設計の原則

### DRY原則（Don't Repeat Yourself）

コードの繰り返しを避け、再利用可能なコンポーネントを作成します。

```go
// 悪い例
func validateEmail(email string) bool {
    // メール検証ロジック
}

func validateUserInput(user User) bool {
    // メール検証ロジックの繰り返し
    // 他の検証ロジック
}

// 良い例
func validateEmail(email string) bool {
    // メール検証ロジック
}

func validateUserInput(user User) bool {
    if !validateEmail(user.Email) {
        return false
    }
    // 他の検証ロジック
}
```

### SOLID原則

#### 単一責任の原則（SRP）

クラスや関数は一つの責任のみを持つべき

```go
// 悪い例
type UserService struct {
    // ...
}

func (s *UserService) Register(user User) {
    // データベースに保存
    // メール送信
    // ログ記録
}

// 良い例
type UserRepository struct {
    // ...
}

func (r *UserRepository) Save(user User) {
    // データベースに保存
}

type MailService struct {
    // ...
}

func (s *MailService) SendWelcomeEmail(user User) {
    // メール送信
}

type UserService struct {
    repo  *UserRepository
    mail  *MailService
    logger *Logger
}

func (s *UserService) Register(user User) {
    s.repo.Save(user)
    s.mail.SendWelcomeEmail(user)
    s.logger.Info("User registered", "user_id", user.ID)
}
```

#### 開放/閉鎖原則（OCP）

ソフトウェアエンティティは拡張に対して開いていて、修正に対して閉じているべき

```go
// 悪い例
type ReportGenerator struct {
    // ...
}

func (g *ReportGenerator) Generate(format string, data []byte) []byte {
    if format == "pdf" {
        // PDF生成ロジック
    } else if format == "csv" {
        // CSV生成ロジック
    } else if format == "json" {
        // JSON生成ロジック
    }
    // 新しいフォーマットを追加するたびに関数を修正
    return nil
}

// 良い例
type ReportFormatter interface {
    Format(data []byte) []byte
}

type PDFFormatter struct{}
func (f *PDFFormatter) Format(data []byte) []byte {
    // PDF生成ロジック
    return formattedData
}

type CSVFormatter struct{}
func (f *CSVFormatter) Format(data []byte) []byte {
    // CSV生成ロジック
    return formattedData
}

// 新しいフォーマットは新しい構造体を追加するだけ
type JSONFormatter struct{}
func (f *JSONFormatter) Format(data []byte) []byte {
    // JSON生成ロジック
    return formattedData
}

type ReportGenerator struct {
    formatter ReportFormatter
}

func (g *ReportGenerator) Generate(data []byte) []byte {
    return g.formatter.Format(data)
}
```

### その他の重要な設計原則

#### 依存性の逆転（Dependency Inversion）

高レベルモジュールは低レベルモジュールに依存すべきではない。両方が抽象に依存すべき。

```go
// 悪い例：直接データベースに依存
type UserService struct {
    db *Database
}

func (s *UserService) GetUser(id string) User {
    return s.db.Query("SELECT * FROM users WHERE id = ?", id)
}

// 良い例：リポジトリインターフェースを介して依存
type UserRepository interface {
    GetUser(id string) User
}

type UserService struct {
    repo UserRepository
}

func (s *UserService) GetUser(id string) User {
    return s.repo.GetUser(id)
}

// 実装はインターフェースを満たす
type DatabaseRepository struct {
    db *Database
}

func (r *DatabaseRepository) GetUser(id string) User {
    return r.db.Query("SELECT * FROM users WHERE id = ?", id)
}
```

#### 関心の分離（Separation of Concerns）

ソフトウェアを異なる関心事に分離する：

- データアクセス層
- ビジネスロジック層
- プレゼンテーション層

## エラー処理とロギング

### 効果的なエラー処理

- **エラーをチェックする**
  ```go
  file, err := os.Open("file.txt")
  if err != nil {
      log.Fatal("エラー: ファイルを開けません:", err)
  }
  ```

- **エラーを適切に伝播する**
  ```go
  func readConfig() (Config, error) {
      file, err := os.Open("config.json")
      if err != nil {
          return Config{}, fmt.Errorf("設定ファイルを開けません: %w", err)
      }
      // ...
  }
  ```

- **コンテキストを持つエラー**
  ```go
  if err := db.Query(...); err != nil {
      return fmt.Errorf("ユーザーID %s のデータ取得中にエラー発生: %w", userId, err)
  }
  ```

### ロギングのベストプラクティス

- **ログレベルを適切に使用する**
  - DEBUG: 詳細なデバッグ情報
  - INFO: 一般的な情報
  - WARN: 潜在的な問題
  - ERROR: エラー状態
  - FATAL: アプリケーションが回復できない致命的エラー

- **構造化ロギング**
  ```go
  logger.Info("ユーザーログイン成功", 
      "user_id", user.ID, 
      "ip_address", req.RemoteAddr,
      "login_time", time.Now())
  ```

## テストの実践

### テストの種類

- **ユニットテスト**: 個々の関数やメソッドをテスト
- **統合テスト**: コンポーネント間の相互作用をテスト
- **エンドツーエンドテスト**: システム全体の動作をテスト
- **パフォーマンステスト**: システムの性能特性をテスト

### テスト駆動開発（TDD）

1. **赤**: 失敗するテストを書く
2. **緑**: テストに合格するコードを最小限書く
3. **リファクタリング**: コードの構造を改善する

### テストのベストプラクティス

- **AAA（Arrange-Act-Assert）パターンを使用する**
  ```go
  func TestUserRegistration(t *testing.T) {
      // Arrange: テストの準備
      userService := NewUserService(mockRepo, mockMailer)
      user := User{Name: "Test User", Email: "test@example.com"}
      
      // Act: テスト対象の機能を実行
      err := userService.Register(user)
      
      // Assert: 期待する結果を検証
      assert.NoError(t, err)
      assert.Equal(t, 1, mockRepo.SaveCallCount)
      assert.Equal(t, 1, mockMailer.SendWelcomeEmailCallCount)
  }
  ```

- **テスト可能なコードを書く**
  - 依存性注入を使用
  - インターフェースを使ってモックを容易にする
  - 副作用を限定的にする

- **テストカバレッジを監視する**
  - 高いカバレッジを目指す（通常80%以上）
  - しかし100%のカバレッジよりも効果的なテストを優先する

## パフォーマンス最適化

### 最適化の原則

1. **まず測定する**: プロファイリングツールを使用して実際のボトルネックを特定
2. **低い実装コストで高いパフォーマンス向上が得られる部分を優先**
3. **早期最適化は諸悪の根源** - クリーンで理解しやすいコードを優先

### 一般的な最適化テクニック

- **効率的なデータ構造の使用**
  - 適切なコレクション型の選択（マップ、セット、配列）
  - インメモリキャッシュの使用

- **リソースの効率的な使用**
  - コネクションプーリング
  - バッファリングとバッチ処理
  - 非同期処理とバックグラウンド処理

## セキュリティ対策

### 一般的なセキュリティプラクティス

- **入力検証**: すべてのユーザー入力を検証
- **パラメータ化クエリ**: SQLインジェクションを防止
- **適切な認証と認可**: セキュアな認証メカニズム
- **最小権限の原則**: 必要最小限の権限のみを付与
- **セキュリティヘッダー**: XSS、CSRF対策

### センシティブデータの処理

- **暗号化**: センシティブなデータを保存/転送時に暗号化
- **ハッシュ化**: パスワードなどを安全にストア（bcrypt、Argon2など）
- **シークレット管理**: API鍵などを適切に管理

## 結論

コード品質とベストプラクティスは、単に「動作する」コードを書くだけではなく、長期的に保守可能で堅牢なソフトウェアを構築するための基盤です。これらの原則とプラクティスを日々の開発作業に取り入れることで、より信頼性が高く、拡張性のあるシステムを作り出すことができます。

最も重要なのは、これらを単なる規則としてではなく、より良いソフトウェア開発のための思考の枠組みとして捉えることです。技術的負債を最小化し、チーム全体の生産性を向上させるために、継続的に学び、実践し、改善することが大切です。