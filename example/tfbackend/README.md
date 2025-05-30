# tfbackend モジュール

このTerraformモジュールは、S3リモートバックエンド用のS3バケットとDynamoDBテーブルを作成します。

## 使い方
`main.tf` 内の `locals` でバケット名やテーブル名を直接指定してください。

```hcl
locals {
  bucket_name         = "your-unique-bucket-name"
  dynamodb_table_name = "your-lock-table-name"
}
```

## 出力値
- `bucket_name`: 作成されたS3バケット名
- `dynamodb_table_name`: 作成されたDynamoDBテーブル名 