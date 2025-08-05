# StorageClassを作成しておく

コードはeksの下

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
< orgAllowlist: "github.com/cnc4e/cloudnative-practice"
---
> orgAllowlist: "<replace-me>"
303c303
<   type: LoadBalancer
---
>   type: NodePort
335c335
<   enabled: false # Ingressを無効化
---
>   enabled: true
```

`token`はPAT。`secret`は一旦dummyを入れる。

```
helm install atlantis runatlantis/atlantis -f values.yaml \
  --set github.user=mouriryouta \
  --set github.token=YOURPAT \
  --set github.secret=dummy
```

podがrunningする。

