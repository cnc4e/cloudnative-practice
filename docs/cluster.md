[Top](../README.md)  

---

# クラスタ構成

## はじめに

アプリケーションアーキテクチャに必要な構成をK8sで実装します。ロードバランサーやボリュームなど、K8s外のリソースもK8sのリソースとして管理します。

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
  python create_issues.py cluster
  ```

自身のGitHubアカウントの`cloudnative-practice`リポジトリを開き、`Issues`タブに`クラスタ`のラベルがついたissueが作成されていることを確認してください。

## issue対応

  - 用途によるノードプールの分割
  - StorageClassによる動的ボリューム作成
  - Ingressによる外部公開

---

[Top](../README.md)  
