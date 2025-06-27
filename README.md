# cloudnative-practiceとは？

クラウドネイティブに関わる複数の技術要素を実践的に学習するための練習教材です。issueをこなしていきながら、実際に手を動かして学ぶことができます。

このプラクティスを行うことで実PJも対応可能な以下のレベルに到達することを目標としています。

- Git
  - 基本的なGitコマンドが使える(clone,pull,push,commit等)
  - issueやPRが使える
    - コードとそれらの紐づけができる
  - issueベースでタスクを進められる
- Terraform
  - 基本的なTerraformコマンドが使える(init,plan,apply等)
  - 独力でコードが書ける
    - 必要なリソース定義を自分で調べて記述できる
    - 変数の受け渡しができる
- K8s
  - 基本的なK8sコマンドが使える(get,describe等)
  - 基本的なK8sのリソース作成ができる
  - helmやeksアドオンを使った機能拡張ができる
- CI/CD
  - セットアップができる
  - ワークフローの作成ができる
- その他
  - Linuxの開発環境を構築できる
  - 改善を繰り返す開発方法（アジャイル）ができる
  - CI/CDやAIなど技術を使った効率改善を考えられる

# 前提

- 以下practiceを実施済
  - [git-practice](https://github.com/cnc4e/git-practice)
    - 2.基礎 まで完了
  - [terraform-practice](https://github.com/cnc4e/terraform-practice)
    - ステップ2　基本的なTerraformの書き方・知識 まで完了
  - [docker-practice](https://github.com/cnc4e/docker-practice)
    - コンテナイメージの基本 まで完了
  - [k8s-practice](https://github.com/cnc4e/k8s-practice)
    - 1.Beginner(初級) まで完了
- AWSアカウントを持っている
- AWSについての基礎的な知識（VPC、subnet等）がある
- GitHubアカウントを持っている
- Linuxの基本的なコマンド(cd、ls等)が使える

# 想定環境

- クラウドはAWSを使います。
- ローカル環境はLinuxを想定しています。
  - Linux環境がない場合、以下を参考にlinux環境を構築してください。
  - [bastion](https://registry.terraform.io/modules/cnc4e/bastion/aws/latest)

# プラクティス

プラクティスは大きく2部構成になっています。`基本構成`はクラウドネイティブの基礎を学ぶための内容で、`追加課題`は実PJに対応可能なレベルを目指すための内容です。

`基本構成`は順番に実施することを推奨します。`追加課題`は興味のあるものを選んで実施してください。

- 基本構成
  - [環境セットアップ](docs/setup.md)
  - [CloudNativeの基礎](docs/cloudnative.md)
  - [構成管理](docs/configuration.md)
  - [コンテナ](docs/container.md)
  - [CI/CD](docs/cicd.md)
  - [オブザーバビリティ](docs/observability.md)
- 追加課題
  - [クラスタ構成]()
    - ノードタイプの混在
    - Ingressを使った外部公開
  - [可用性](docs/availability.md)
    - service（基本すぎるのでやらない）
    - probe
    - graceful shutdown
    - affinity
    - PDB
    - ptsc
    - update strategy
  - [性能・拡張性](docs/scalability.md)
    - resources
    - HPA
    - VPA
    - ノードの拡張
  - [可観測性](docs/advanced-observability.md)
    - ロググループの分割
    - ログの構造化
    - 構造化ログのメトリクス化
    - Application Insights を使った可視化
  - [セキュリティ](docs/security.md)
    - クラスタセキュリティ
      - エンドポイントの種類
      - エンドポイントへのアクセス制限
      - クラスタの監査ログ
    - Podのセキュリティ
      - NetworkPolicy
      - Security Group Policy
      - K8s RBAC
      - Pod Identity（すでにやっているからやらない）
      - SecurityContext
      - Falco
    - Nodeのセキュリティ
      - SELinuxの有効化
      - GuradDuty Malware Protection
    - コンテナのセキュリティ
      - 信頼できる提供元のイメージを使用
      - イメージスキャン
      - 必要最小限のもの（マルチステートビルド）
      - プライベートレジストリ
    - IaCセキュリティ
      - 機密情報の管理
  - [運用・保守](docs/operations.md)
    - ポリシー制御
    - CI/CDの活用
      - イメージスキャン
      - 静的解析
      - Planの実施
      - ドリフト検知
    - ブランチ戦略
    - クラスタのバージョンアップ
