# 導入手順

## ARCのインストール

[Actions Runner Controller のクイックスタート](https://docs.github.com/en/actions/hosting-your-own-runners/managing-self-hosted-runners-with-actions-runner-controller/quickstart-for-actions-runner-controller)

``` sh
helm install arc \
    --namespace arc-systems \
    --create-namespace \
    oci://ghcr.io/actions/actions-runner-controller-charts/gha-runner-scale-set-controller
```

## GitHubの認証設定

以下のいずれか。PATの方が簡単。GitHub Appは個人に紐づかないのでPJ利用にいい。

[Authenticating to the GitHub API](https://docs.github.com/en/actions/hosting-your-own-runners/managing-self-hosted-runners-with-actions-runner-controller/authenticating-to-the-github-api#deploying-using-personal-access-token-classic-authentication)

### PAT

``` sh
kubectl create secret generic pre-defined-secret \
   --namespace=arc-runners \
   --from-literal=github_token='YOUR-PAT'
```

## GitHub App

``` sh
kubectl create secret generic pre-defined-secret \
   --namespace=arc-runners \
   --from-literal=github_app_id=1282501 \
   --from-literal=github_app_installation_id=67015495 \
   --from-file=github_app_private_key=github_app_private_key.pem
```

## スケールセットのデプロイ

```
helm install arc-runner-set \
    --namespace arc-runners \
    --create-namespace \
    --set githubConfigUrl=https://github.com/cnc4e/cloudnative-practice \
    --set githubConfigSecret=pre-defined-secret \
    oci://ghcr.io/actions/actions-runner-controller-charts/gha-runner-scale-set
```


# 参考にしたもの

## GitHubドキュメント

[自己ホスト ランナーの概要](https://docs.github.com/ja/actions/hosting-your-own-runners/managing-self-hosted-runners/about-self-hosted-runners)
[Actions Runner Controller について](https://docs.github.com/ja/actions/hosting-your-own-runners/managing-self-hosted-runners-with-actions-runner-controller/about-actions-runner-controller)
[アクション ランナー コントローラーのクイック スタート](https://docs.github.com/ja/actions/hosting-your-own-runners/managing-self-hosted-runners-with-actions-runner-controller/quickstart-for-actions-runner-controller)
[GitHub API に対する認証を行う](https://docs.github.com/ja/actions/hosting-your-own-runners/managing-self-hosted-runners-with-actions-runner-controller/authenticating-to-the-github-api)

## リポジトリ

[Actions Runner Controller (ARC)](https://github.com/actions/actions-runner-controller)
[Installing ARC](https://github.com/actions/actions-runner-controller/blob/master/docs/installing-arc.md)
[Authenticating to the GitHub API](https://github.com/actions/actions-runner-controller/blob/master/docs/authenticating-to-the-github-api.md)
[Deploying ARC runners](https://github.com/actions/actions-runner-controller/blob/master/docs/deploying-arc-runners.md)

## ブログ

[Azure Kubernetes Service にActions Runner Controller を導入しSelf-hosted runner 環境を構築する](https://kdkwakaba.com/articles/deploy-actions-runner-controller-on-aks)