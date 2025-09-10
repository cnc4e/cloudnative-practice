[Top](../README.md)  

---

# 運用・保守

## はじめに

このプラクティスでは、本番環境でのKubernetesクラスターの運用・保守について学習します。

運用・保守は、システムを安定して稼働させ続けるための重要な活動です。K8sを使うクラウドネイティブなプロジェクトでは継続的な開発を行うことが多いです。そのため、効率よく継続的な開発を行うための仕組みづくりが重要になります。また、定期的なメンテナンス、アップデートも重要です。

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
  python create_issues.py security
  ```

自身のGitHubアカウントの`cloudnative-practice`リポジトリを開き、`Issues`タブに`セキュリティ`のラベルがついたissueが作成されていることを確認してください。

## issue対応

### ポリシーチェック

  - Checkovによるポリシーチェック

### CI/CDの活用

  - CheckovによるポリシーチェックをCIに組み込む
  - AtlantisによるPRベースのterraform plan/apply
  - GitHub Actionsによる定期的なドリフトチェック

### Git

  - ブランチ戦略
  - リポジトリ設定

### コード管理

  - Terraform構成管理
  - K8sマニフェスト構成管理

### クラスタのメンテナンス

  - EKSクラスタのバージョンアップ
  - Veleroを使ったバックアップとリストア

---

[Top](../README.md)  
