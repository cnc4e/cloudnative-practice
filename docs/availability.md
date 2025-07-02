[Top](../README.md)  

---

# 可用性

このプラクティスでは、Kubernetesクラスターでアプリケーションの可用性を向上させるための設定について学習します。

可用性（Availability）とは、システムが継続的に稼働し、利用可能な状態を維持することです。

CloudNativeなアプリケーションでは、以下の要素が可用性に影響を与えます。

- ネットワーク
  - 可用性ゾーン
  - Gateway
  - 負荷分散
- K8s
  - コントロールプレーン
  - ノード
  - ワークロード
- データ
  - データベース
  - キャッシュ
  - ストレージ

ネットワークとデータについてはクラウドプロバイダーのベストプラクティスに従うことが一般的です。

K8sのコントロールプレーンはマネージドサービスを利用することで高い可用性を確保できます。ノードの可用性は、クラウドプロバイダーのインフラに依存しますが、オートスケーリングやKarpenterを利用することで向上させることができます。EKS Automode では Karpenter が使われています。

K8sのワークロードに関する設定は利用者が直接管理できる部分です。そのため、ワークロードの設定を適切に行うことで、アプリケーションの可用性を大幅に向上させることができます。

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
  python create_issues.py availability
  ```

自身のGitHubアカウントの`cloudnative-practice`リポジトリを開き、`Issues`タブに`可用性`のラベルがついたissueが作成されていることを確認してください。

## issue対応

以下タイトルのissueを対応してください。issueを対応する流れは[こちら](./practice-flow.md)を参照してください。コーディングルールは[こちら](./coderule.md)を参照してください。もし詰まってしまった場合、[example](../example)ディレクトリにサンプルコードを用意していますので参考にしてください。

  - 基本的な可用性設定
  - Podにヘルスチェックを設定する（probe）
  - Podにgracefulshutdownを設定する
  - Podにaffinityを設定する
  - PodDisruptionBudget（PDB）を設定する
  - DeploymentのUpdate Strategyを設定する

---

[Top](../README.md)  
