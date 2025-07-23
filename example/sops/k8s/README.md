`.sops.yaml`はプロジェクトのrootに配置

``` sh
sops encrypt --encrypted-regex '^data' -i secret.yaml
```

``` sh
sops -d -i secret.yaml
```
