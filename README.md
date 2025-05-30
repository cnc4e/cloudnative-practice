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
  - git
  - terraform
  - docker
  - k8s
- AWSアカウントを持っている
- AWSについての基礎的な知識（VPC、subnet等）がある
- Linuxの基本的なコマンド(cd、ls等)が使える

# 想定環境

- クラウドはAWSを使います。
- ローカル環境はLinuxを想定しています。
  - Linux環境がない場合、以下を参考にlinux環境を構築してください。
  - [bastion](https://registry.terraform.io/modules/cnc4e/bastion/aws/latest)

# プラクティス

1. [環境セットアップ](docs/setup.md)
2. [CloudNativeの基礎](docs/cloudnative.md)
3. [構成管理](docs/configuration.md)
4. [コンテナ](docs/container.md)
5. [CI/CD](docs/cicd.md)
6. [オブザーバビリティ](docs/observability.md)

- 可用性
  - ヘルスチェック
  - アップデート戦略
  - 安全なPod停止
- セキュリティ
  - コンテナ
    - イメージの設定
    - イメージスキャン
  - Pod
    - Podの設定
    - Podの通信制限
- 運用
  - 保守アクセス
  - クラスタバージョンアップ
