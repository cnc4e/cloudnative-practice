[Top](../README.md)  

---

# 性能・拡張性

## はじめに

このプラクティスでは、Kubernetesクラスターでアプリケーションの性能と拡張性を向上させるための設定について学習します。

性能（Performance）とは、システムがどれだけ効率的に動作するかを示し、拡張性（Scalability）とは、負荷の変化に応じてシステムを適切に拡張・縮小する能力を指します。

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
  python create_issues.py scale
  ```

自身のGitHubアカウントの`cloudnative-practice`リポジトリを開き、`Issues`タブに`拡張性`のラベルがついたissueが作成されていることを確認してください。

## issue対応

### ノード

  - ワーカーの拡張

### Pod

  - メトリクスサーバーの導入
  - HPAによるオートスケール
  - In-Place Pod Vertical Scaling (IPVS)によるリソース増強
  - VPAによるPodの自動スケールアップ

---

[Top](../README.md)  
