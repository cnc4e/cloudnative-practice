[KubernetesでFalcoを試す](https://falco.org/docs/getting-started/falco-kubernetes-quickstart/)
[Kubernetes へのデプロイ](https://falco.org/docs/setup/kubernetes/)

```
helm repo add falcosecurity https://falcosecurity.github.io/charts
helm repo update
```

```
helm install --replace falco --namespace falco --create-namespace --set tty=true falcosecurity/falco
```