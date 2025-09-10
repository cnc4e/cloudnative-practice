issueを作成するスクリプト群です。

# 使い方:

1. 必要な環境変数をセットしてください:
   - GITHUB_TOKEN: GitHubのPersonal Access Token
   - GITHUB_REPO: <owner>/<repo> 形式のリポジトリ名

2. issue作成:

```zsh
python create_issues.py configuration
python create_issues.py container
```

- ラベルやissue内容は `issue_settings.yaml` で管理します。
- 各種issueリストは `container.yaml` や `configuration.yaml` で管理します。
