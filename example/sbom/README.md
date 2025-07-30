# SBOMの作成

`SPDX`の形式はDependency-Trackでの可視化に対応していないようだ。`CycloneDX`の形式でSBOMを作成する。

```
trivy image --format cyclonedx --output result.json 456247443832.dkr.ecr.ap-northeast-2.amazonaws.com/frontend:202507181652
```

# Dependency-Trackのインストール

```
helm repo add dependency-track https://dependencytrack.github.io/helm-charts
helm install dtrack dependency-track/dependency-track \
    --namespace dtrack --create-namespace
```

# Dependency-Trackへのアクセス

## ポートフォワードで接続する場合

localhostでポートフォワードする場合、APIとFrontendで同じポートを使えない。以下のようにFrontendが認識するAPIのベースURLを設定する

```
helm upgrade dtrack dependency-track/dependency-track \
    --namespace dtrack \
    --set frontend.apiBaseUrl=http://localhost:8080
```

APIとFrontendを別のポートでフォワード

```
kubectl port-forward service dtrack-dependency-track-frontend -n dtrack 8081:8080
kubectl port-forward service dtrack-dependency-track-api-server -n dtrack 8080:8080
```

`localhost:8081`でFrontendにアクセス。初期は**admin/admin**。
初回ログイン時にパスワードを変更する必要がある。

# SBOMの可視化

- Dependency-Trackでプロジェクトを作成する
- Project作成後、`Components`タブを開き`Upload BOM`をクリックする。trivyで作成したSBOMをアップロードする
- `Dependency Graph`タブを開くと、SBOMの内容が可視化される
