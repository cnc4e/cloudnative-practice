# インストール

```
helm repo add argo https://argoproj.github.io/argo-helm
```

```
helm install -n argocd argocd \
--create-namespace \
argo/argo-cd
```

# ログイン

```
kubectl get secret -n argocd argocd-initial-admin-secret -o yaml
```

```
echo RDl5OFdmcmM0RkZhYkxaYw== | base64 -d
```

```
kubectl port-forward svc/argocd-server -n argocd 8080:443
```

# ImageUpdater

```
helm install -n argocd argocd-image-updater argo/argocd-image-updater
```

# ArgoCDにKSOPSを追加

```
helm upgrade -n argocd argocd argo/argo-cd -f values.yaml
```

