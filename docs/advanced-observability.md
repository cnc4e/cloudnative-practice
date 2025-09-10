[Top](../README.md)  

---

# 高度な可観測性

## はじめに

このプラクティスでは、Kubernetesクラスターとアプリケーションの可観測性（Observability）を向上させるための高度な監視・ロギング・トレーシング技術について学習します。

可観測性とは、システムの内部状態を外部から観察・理解できる能力のことで、メトリクス、ログ、トレースの3つの柱で構成されます。

# プラクティス

## issue作成

自身のGitHubアカウントに作成した`cloudnative-practice`リポジトリにIssueを作成します。issueを作成するスクリプトを用意しているためそれを使います。

- まずはリポジトリのルートから以下コマンドで`scripts`ディレクトリに移動

  ``` sh
  cd scripts
  ```

- 環境変数に値を設定

  ``` sh
  export GITHUB_TOKEN={あなたのGitHubのPAT}
  export GITHUB_REPO={あなたのGitHubアカウント名}/cloudnative-practice
  ```

- スクリプト実行

  ``` sh
  python create_issues.py o11y-advance
  ```

自身のGitHubアカウントの`cloudnative-practice`リポジトリを開き、`Issues`タブに`オブザーバビリティ（高度）`のラベルがついたissueが作成されていることを確認してください。

## issue対応


### ログ

  - ロググループの分割
  - ログの構造化
  - 構造化ログのメトリクス化

### メトリクス

  - Application Insights を使った可視化

---

[Top](../README.md)  
