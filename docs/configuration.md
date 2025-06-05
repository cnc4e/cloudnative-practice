
[Top](../README.md)  
前: [CloudNativeの基礎](./cloudnative.md)  
次: [コンテナ](./container.md)

---

# インフラの構成管理

- [インフラの構成管理](#インフラの構成管理)
- [構成管理がなぜ必要か](#構成管理がなぜ必要か)
- [構成管理の要素](#構成管理の要素)
  - [Git](#git)
  - [IaC（Terraform、K8s）](#iacterraformk8s)
- [プラクティス](#プラクティス)
  - [issue作成](#issue作成)
  - [issue対応](#issue対応)
  - [issue対応後](#issue対応後)

# 構成管理がなぜ必要か

インフラの構成管理は、システムの安定運用や再現性の確保、変更履歴の追跡、チームでの協調作業を実現するために不可欠です。構成管理を行うことで、誰が・いつ・どのような変更を加えたかを明確にし、障害発生時の迅速な復旧や、環境の再構築を容易にします。

CloudNativeのアプローチで求められる柔軟性やスケーラビリティを実現するためには、インフラの構成管理が特に重要です。これにより、環境の変更を迅速かつ安全に行うことができ、開発・運用の効率化が図れます。

# 構成管理の要素

## Git

Gitは分散型バージョン管理システムであり、インフラ構成ファイル（例：TerraformコードやKubernetesマニフェスト）を管理する中心的な役割を担います。Gitを利用することで、構成ファイルの変更履歴を記録し、ブランチやプルリクエストを活用したレビュー・承認フローを実現できます。これにより、インフラの変更もアプリケーション開発と同様にコードとして管理（Infrastructure as Code: IaC）でき、品質やセキュリティの向上につながります。

## IaC（Terraform、K8s）

IaC（Infrastructure as Code）は、インフラの構成や設定をコードとして記述・管理する手法です。本プラクティスでは以下のIaCを使います。

- **Terraform**  
  クラウドリソース（VPC、サーバー、ネットワーク等）を宣言的に定義し、コードで管理・自動構築できます。Gitと連携することで、構成の変更をコードレビューしながら安全に適用できます。

- **Kubernetes（K8s）**  
  アプリケーションのデプロイやサービス定義をYAMLファイルで記述し、クラスタ上に適用します。これらのマニフェストもGitで管理することで、環境の再現性や変更履歴の追跡が容易になります。

このように、GitとIaCを組み合わせることで、インフラの構成管理を効率化し、信頼性・可搬性の高い運用が可能となります。

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
  python create_issues.py configuration
  ```

自身のGitHubアカウントの`cloudnative-practice`リポジトリを開き、`Issues`タブに`構成管理`のラベルがついたissueが作成されていることを確認してください。

## issue対応

> 注意: issue対応はGitやTerraformの基本的な使い方を理解していることが前提です。[git-practice](https://github.com/cnc4e/git-practice)や[terraform-practice](https://github.com/cnc4e/terraform-practice)を先に学習してください。

以下タイトルのissueを対応してください。issueを対応する流れは[こちら](./practice-flow.md)を参照してください。コーディングルールは[こちら](./coderule.md)を参照してください。もし詰まってしまった場合、[example](./example)ディレクトリにサンプルコードを用意していますので参考にしてください。

- Terraformバックエンドを作成する
- ネットワークを作成する

作成する環境は以下のイメージ図です。

![configuration](./images/configuration.drawio.svg

## issue対応後

IaCやGitはCloudNativeの基礎であり重要な要素です。今後のプラクティスでも頻繁に使用します。初めは慣れなくても、繰り返し使うことで自然と身についていきますので安心してください。次のプラクティスでは簡単なWEBサービスを作成しつつコンテナを学びます。

---

[Top](../README.md)  
前: [CloudNativeの基礎](./cloudnative.md)  
次: [コンテナ](./container.md)  
