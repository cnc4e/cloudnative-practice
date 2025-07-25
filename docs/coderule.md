# Terraform コーディングルール

## 1. ファイル構成
- リソース群（モジュール）ごとにディレクトリを分割する。
- ファイルは`main.tf`, `variables.tf`, `outputs.tf`, `provider.tf` などに分割する。
  - リソースが多い場合、`main.tf` をさらに分割する（例: `vpc.tf`, `ec2.tf`）。
  - 参考: [File names](https://developer.hashicorp.com/terraform/language/style#file-names)

## 2. 命名規則
- Terraformリソース名、変数名、出力名は一貫性を持たせ、スネークケース（例: `vpc_id`）を使用する。
- ファイル名・ディレクトリ名もスネークケースで統一する。
- AWSリソース名などは、環境名や用途を含めて命名する（例: `dev-app-vpc`）。
- tfstateの名前はモジュール名（ディレクトリ名）と同じにする（例: `network.tfstate`）。

## 3. 変数・出力
- 変数には型・説明・デフォルト値を必ず設定する。
- センシティブな値（パスワード等）は `sensitive = true` を設定し、環境変数や外部シークレット管理サービスを利用する。
- 出力値（outputs）は必要最小限とし、用途を明記する。

## 4. コーディングスタイル
- インデントはスペース2つで統一する。
- 公式の `terraform fmt` で自動整形する。
- Terraformリソース内は以下の順番で記述する。
  - ループのメタ引数（例：`for_each`,`count`）
  - 非ブロックパラメーター
  - ブロックパラメーター
  - `tags` ブロック
  - `lifecycle` ブロック
  - `depends_on` ブロック
- ブロック間は空行を入れ、可読性を高める。
- 非ブロックパラメーターは、空行を入れずに続けて記述する。

## 5. セキュリティ
- ハードコーディングを避け、機密情報は外部で管理する。
- 不要なポート開放や権限付与を避ける。
- `terraform plan` で差分を必ず確認し、意図しない変更がないかレビューする。

## 6. バージョン管理
- `terraform.lock.hcl` を必ずコミットし、プロバイダーのバージョンを固定する。
- `state` ファイルはリモートバックエンド（S3等）で管理し、ローカルには置かない。
  - stateのキー名はモジュール名と同じにする（例: `network.tfstate`）。
- Terraform本体のバージョン（`terraform`ブロックの`required_version`）および各プロバイダーのバージョン（`required_providers`）を必ず明示的に指定する。これらは通常、`provider.tf`や`versions.tf`などのファイルに記述する。
- `.gitignore` に `.terraform` や `*.tfstate` を追加し、不要なディレクトリ・ファイルをGitで管理しないようにする。

# Kubernetesマニフェスト コーディングルール

## 1. 基本方針
- YAML形式で記述する（JSON不可）
- インデントは **スペース2つ**
- 拡張子は `.yaml` を使用する（`.yml`ではなく）

## 2. ファイル構成
- リソース種別ごとにファイルを分ける（例：`deployment.yaml`, `service.yaml`）
- 単一ファイル内に複数リソースを定義する場合は `---` 区切りを使用
- 名前空間ごとにディレクトリを分けてもよい（例：`namespaces/prod/deployment.yaml`）

## 3. 命名規則
- リソース名はすべて **小文字・ハイフン区切り**
  - 例: `web-backend-deployment`

## 4. コメント

- 設定の意図や注意点が伝わるよう、重要な項目にはコメントを記載する
- `#` を使い、該当行の直前か右端に記載する

例：

```yaml
# アプリケーションのHTTPポートを指定
ports:
  - containerPort: 8080  # 外部からのアクセス用
```


