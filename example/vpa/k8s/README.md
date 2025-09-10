.gitignoreでクローンしたリポジトリをGit管理外にしている。以下コマンドでクローンおよびいインストールした。

参考: [Vertical Pod Autoscaler を使用してポッドリソースを調整する](https://docs.aws.amazon.com/ja_jp/eks/latest/userguide/vertical-pod-autoscaler.html)


```
git clone https://github.com/kubernetes/autoscaler.git
```

```
cd autoscaler/vertical-pod-autoscaler/
```

```
./hack/vpa-up.sh
```

```
cd example
```

```
kubectl apply -f hamaster.yaml
```

```
kubectl delete -f hamaster.yaml
cd ../
./hack/vpa-down.sh
```
