
# GitHubドキュメント

[自己ホスト ランナーの概要](https://docs.github.com/ja/actions/hosting-your-own-runners/managing-self-hosted-runners/about-self-hosted-runners)
[Actions Runner Controller について](https://docs.github.com/ja/actions/hosting-your-own-runners/managing-self-hosted-runners-with-actions-runner-controller/about-actions-runner-controller)
[アクション ランナー コントローラーのクイック スタート](https://docs.github.com/ja/actions/hosting-your-own-runners/managing-self-hosted-runners-with-actions-runner-controller/quickstart-for-actions-runner-controller)
[GitHub API に対する認証を行う](https://docs.github.com/ja/actions/hosting-your-own-runners/managing-self-hosted-runners-with-actions-runner-controller/authenticating-to-the-github-api)

# リポジトリ

[Actions Runner Controller (ARC)](https://github.com/actions/actions-runner-controller)
[Installing ARC](https://github.com/actions/actions-runner-controller/blob/master/docs/installing-arc.md)
[Authenticating to the GitHub API](https://github.com/actions/actions-runner-controller/blob/master/docs/authenticating-to-the-github-api.md)
[Deploying ARC runners](https://github.com/actions/actions-runner-controller/blob/master/docs/deploying-arc-runners.md)


# ブログ

[Azure Kubernetes Service にActions Runner Controller を導入しSelf-hosted runner 環境を構築する](https://kdkwakaba.com/articles/deploy-actions-runner-controller-on-aks)


# 導入手順

## Namespaceの作成

``` sh
kubectl apply -f ns.yaml
```

## GitHub Appの認証情報をSecretに登録

[Authenticating to the GitHub API](https://github.com/actions/actions-runner-controller/blob/master/docs/authenticating-to-the-github-api.md)

``` sh
kubectl create secret generic controller-manager \
    -n actions-runner-system \
    --from-literal=github_app_id=1282501 \
    --from-literal=github_app_installation_id=67015495 \
    --from-file=github_app_private_key=github_app_private_key.pem

```

## ARCのインストール

[Installing ARC](https://github.com/actions/actions-runner-controller/blob/master/docs/installing-arc.md)

```
helm repo add actions-runner-controller https://actions-runner-controller.github.io/actions-runner-controller
helm upgrade --install --namespace actions-runner-system \
  --wait actions-runner-controller actions-runner-controller/actions-runner-controller
```

