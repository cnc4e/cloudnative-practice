# 前提AWSリソースを作成

- バックアップ保管用S3バケット
  - PJ名-velero-backups
- velero用IAMロールおよび Pod Identity
  - ポリシーは[ここ](https://aws.amazon.com/jp/blogs/containers/backup-and-restore-your-amazon-eks-cluster-resources-using-velero/)を参考にする
  - SAは`velero-server`
- EKSアドオン
  - `ebs-csi`を有効化する（auto modeだとデフォルトで有効）
  - `snapshot-controller`を有効化する

# CLIのインストール

```
wget https://github.com/vmware-tanzu/velero/releases/download/v1.16.2/velero-v1.16.2-linux-amd64.tar.gz
tar -xvf velero-v1.16.2-linux-amd64.tar.gz
sudo mv velero-v1.16.2-linux-amd64/velero /usr/local/bin/
velero version
```

# Helmインストール

```
helm repo add vmware-tanzu https://vmware-tanzu.github.io/helm-charts
```

```
helm show values vmware-tanzu/velero > values.yaml
```

```
diff values.yaml values_old.yaml
<   - name: velero-plugin-for-aws
<     image: velero/velero-plugin-for-aws:v1.12.2
<     imagePullPolicy: IfNotPresent
<     volumeMounts:
<       - mountPath: /target
<         name: plugins
---
>   # - name: velero-plugin-for-aws
>   #   image: velero/velero-plugin-for-aws:v1.12.2
>   #   imagePullPolicy: IfNotPresent
>   #   volumeMounts:
>   #     - mountPath: /target
>   #       name: plugins
377c377
<     provider: "aws"
---
>     provider: ""
379c379
<     bucket: "cn-practice-velero-backups"
---
>     bucket: ""
425c425
<     provider: "aws"
---
>     provider: ""
433,434c433
<     config:
<       region: ap-northeast-2
---
>     config: {}
502c501
<   features: EnableCSI
---
>   features:
617c616
<   useSecret: false
---
>   useSecret: true
```

```
helm install velero vmware-tanzu/velero \
    --create-namespace \
    --namespace velero \
    -f values.yaml
```

# サンプルアプリ作成

```
kubectl apply -f namesapce.tf
kubectl apply -f pvc.tf
kubectl apply -f deployment.tf
```

# バックアップ作成

```
velero backup create velero-sample --include-namespaces velero-sample
velero backup describe velero-sample
```

# リソース削除

```
kubectl delete -f deployment.yaml
kubectl delete -f pvc.yaml
```

# リストア実施

```
velero restore create velero-sample \
    --from-backup velero-sample \
    --include-namespaces velero-sample
```

```
velero restore describe velero-sample
```


# 参考

- [Backup and restore your Amazon EKS cluster resources using Velero](https://aws.amazon.com/jp/blogs/containers/backup-and-restore-your-amazon-eks-cluster-resources-using-velero/)
- [EKSでVeleroを使ったリストアを試してみる](https://zenn.dev/fusic/articles/80b63839bd2088)