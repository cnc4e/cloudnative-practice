``` sh
export SOPS_KMS_ARN=arn:aws:kms:ap-northeast-2:ACCOUNTID:key/9cc09cd4-f4c5-4796-9a47-XXXXXXXXXXXX
sops encrypt --encrypted-regex '^data' -i secret.yaml
```

``` sh
sops -d -i secret.yaml
```
