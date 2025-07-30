

https://istio.io/latest/docs/ambient/install/helm/

リポジトリ登録

```
helm repo add istio https://istio-release.storage.googleapis.com/charts
helm repo update
```

CRD作成

```
helm install istio-base istio/base -n istio-system --create-namespace --wait
```

Kubernetes Gateway API CRD

```
wget https://github.com/kubernetes-sigs/gateway-api/releases/download/v1.3.0/standard-install.yaml
kubectl apply -f standard-install.yaml
```

istiod

```
helm install istiod istio/istiod --namespace istio-system --set profile=ambient --wait
```

cni

```
helm install istio-cni istio/cni -n istio-system --set profile=ambient --wait
```

ztunnel

```
helm install ztunnel istio/ztunnel -n istio-system --wait
```

確認

```
$ kubectl get pod -n istio-system
NAME                      READY   STATUS    RESTARTS   AGE
istio-cni-node-7jjph      1/1     Running   0          2m28s
istio-cni-node-scmvc      1/1     Running   0          2m28s
istiod-84c789b44f-2bxtj   1/1     Running   0          23m
ztunnel-f9k9w             1/1     Running   0          20s
ztunnel-xmpml             1/1     Running   0          20s
```

ns:defaultをアンビエントメッシュの一部にする

```
kubectl label namespace default istio.io/dataplane-mode=ambient
```

可視化

```
kubectl apply -f https://raw.githubusercontent.com/istio/istio/release-1.26/samples/addons/prometheus.yaml
kubectl apply -f https://raw.githubusercontent.com/istio/istio/release-1.26/samples/addons/kiali.yaml
```
