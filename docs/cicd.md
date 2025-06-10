# CI/CD

コンテナのプラクティスでコンテナイメージのビルドとデプロイを手動で行いましたが非常に手間だったと思います。クラウドネイティブなシステムだと、コンテナイメージの更新は頻繁に行われるため、さらに面倒です。そこで、CI/CDを導入し、コンテナのビルドやデプロイを自動化することを学びます。

CI/CDは、ソフトウェア開発における継続的インテグレーション（CI: Continuous Integration）と継続的デリバリー／デプロイメント（CD: Continuous Delivery/Deployment）を組み合わせた開発手法です。これにより、コードの変更を自動的にビルド、テスト、デプロイすることで、品質向上やリリースの迅速化を実現します。

## CIとは

CI（継続的インテグレーション）は、開発者が行ったコードの変更を頻繁に統合し、自動でビルドやテストを実行するプロセスです。これにより、バグの早期発見や品質の維持が可能となり、開発効率が向上します。GitHub Actions や GitLab CI などGitベースのCIツールが広く利用されています。また、Jenkins や CircleCI などの独立したCIツールもあります。

## CDとは

CDには2つの意味があります。
- 継続的デリバリー（Continuous Delivery）：CIの後、テスト済みのコードを本番環境にリリースできる状態まで自動化すること。
- 継続的デプロイメント（Continuous Deployment）：継続的デリバリーのさらに先で、テストに合格したコードを自動的に本番環境へデプロイすること。

どちらもリリース作業の自動化・迅速化を目的としています。K8sのCDツールとしては Argo CD が有名です。GitHub Actions などのCIツールでもCDできる機能を持つものがあります。

# GitOps

GitOps（ギットオプス）は、インフラやアプリケーションのデプロイ、運用、管理をすべてGitリポジトリで管理する手法です。インフラやアプリの設定ファイルをGitでバージョン管理し、変更があれば自動的にシステムへ反映（デプロイ）します。

GitOpsの主な特徴:
- インフラやアプリの状態をGitで一元管理し、変更履歴を追跡できる
- Pull Requestやマージによる変更管理で、レビューや承認フローを組み込める
- 自動化ツール（例: Argo CD, Flux）がGitの状態と実際の環境を同期し、差分があれば自動で反映
- 再現性・監査性が高く、トラブル時のロールバックも容易

Kubernetes環境で特に活用されており、クラウドネイティブな運用のベストプラクティスの一つとされています。

- Kubernetes向け
  - Argo CD: Kubernetesクラスタの状態をGitリポジトリと同期する代表的なツール。
  - Flux: Gitリポジトリの変更を監視し、Kubernetesリソースを自動的に適用。
- Terraform向け
  - Atlantis: GitHubなどのPull Requestと連携し、Terraformのplan/applyを自動化。
  - Terraform Cloud/Enterprise: VCS連携によるGitOps的なワークフローをサポート。

これらのツールを活用することで、KubernetesやTerraformによるインフラ管理もGitOpsの考え方で自動化・効率化できます。

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
  python create_issues.py cicd
  ```

自身のGitHubアカウントの`cloudnative-practice`リポジトリを開き、`Issues`タブに`CI/CD`のラベルがついたissueが作成されていることを確認してください。

## issue対応

以下タイトルのissueを対応してください。issueを対応する流れは[こちら](./practice-flow.md)を参照してください。コーディングルールは[こちら](./coderule.md)を参照してください。もし詰まってしまった場合、[example](./example)ディレクトリにサンプルコードを用意していますので参考にしてください。

- GitHub Actions Runnerをセットアップする
- フロンエンドのコンテナをビルドしてECRにプッシュするワークフローを作成する
- バックエンドのコンテナをビルドしてECRにプッシュするワークフローを作成する
- Argo CD をセットアップする
- フロントエンドのデプロイをGitOpsで行う
- バックエンドのデプロイをGitOpsで行う

作成する環境は以下のイメージ図です。

![configuration](./images/container.drawio.svg

## issue対応後

コンテナの更新はイメージをビルドし、レジストリにプッシュしてから、Kubernetesのマニフェストを更新する必要があり非常に手間がかかります。本プラクティスのコンテナイメージはかなり軽量なのでビルド時間もそこまでかかりませんでしたが、業務であつかうイメージとなるとそれなりに時間かかります。そこで、CI/CDツールを使って自動化することを推奨します。次のプラクティスではCI/CDを導入し作業を自動化します。

