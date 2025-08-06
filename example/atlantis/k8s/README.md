# StorageClassを作成しておく

コードはeksの下

# IngressClassを作成しておく

コードはeksの下

# GitHubアクセス用の認証情報を用意

PAT or GitHub Appを作成しておく。今回はARCで作成したPATを使用する。

# webhook secretを作成しておく

適当な24文字より長い文字列を作成しておく。

# Atlantisのデプロイ

https://www.runatlantis.io/docs/deployment.html#kubernetes-helm-chart

```
helm repo add runatlantis https://runatlantis.github.io/helm-charts
```

```
helm inspect values runatlantis/atlantis > values.yaml
```

values.yamlを編集して、必要な設定を行います。

```
$ diff values.yaml values_old.yaml
18c18
< orgAllowlist: "github.com/cnc4e/cloudnative-practice"
---
> orgAllowlist: "<replace-me>"
303c303
<   type: ClusterIP
---
>   type: NodePort
336c336
<   ingressClassName: alb
---
>   ingressClassName:
345c345
<   path: /events
---
>   path: /*
```

`token`はPAT。`secret`は作成したwebhook用の文字列を入れる。どちらもbase64エンコードする必要はない。

```
helm install atlantis runatlantis/atlantis -f values.yaml \
  --set github.user=mouriryouta \
  --set github.token=YOURPAT \
  --set github.secret=YOURWEBHOOKSECRET
```

podがrunningする。IngressのDNS名を確認しておく。

# GitHubのwebhook設定

リポジトリの画面から`Settings`->`Webhooks`->`Add webhook`を選択。以下を入力して`Add webhook`をクリック。

- Payload URL: IngressのDNS名を入力
- Content type: `application/json`
- Secret: 作成したwebhook用の文字列を入力
- SSL verification: 今回は`Disable`
- Which events would you like to trigger this webhook?
  - Let me select individual events.
    - Pull request
    - Pull request reviews
    - Push
    - Issue comment
- Active: チェックを入れる

# AtlantisにPod Identityを設定

SA:`atlantis`にPod Identityで権限を付与する。applyまでするなら`AdministratorAccess`を付与する。planだけなら`ReadOnlyAccess`。
tfbackendへのアクセス権も必要。stateロックのためにS3またはDynamoDBへのアクセス権も必要。
S3側のリソースポリシーでIAMロールの制限をしている場合、Atlantis用のIAMロールを追加する。

# 動作確認

Terraformのコードを修正したコミットをプッシュし、PRを作成する。Atlantisにより自動でplanが実行され結果がPRにコメントされることを確認する。
