import os
import requests
import yaml

# 設定
GITHUB_TOKEN = os.environ.get('GITHUB_TOKEN')
GITHUB_REPO = os.environ.get('GITHUB_REPO')
# REPO_OWNER = os.environ.get('REPO_OWNER')
# REPO_NAME = os.environ.get('REPO_NAME')

# ラベル

labels = [
    {
        'name': '構成管理',
        'color': '1f77b4',
        'description': 'インフラや設定の管理'
    }
]

# YAMLからIssueリストを読み込み
with open(os.path.join(os.path.dirname(__file__), "configuration.yaml"), encoding="utf-8") as f:
    issues = yaml.safe_load(f)["issues"]

# APIエンドポイント
label_url = f'https://api.github.com/repos/{GITHUB_REPO}/labels'
issue_url = f'https://api.github.com/repos/{GITHUB_REPO}/issues'

# ヘッダー
headers = {
    'Authorization': f'token {GITHUB_TOKEN}',
    'Accept': 'application/vnd.github.v3+json'
}

# ラベル作成
for label in labels:
    data = {
        'name': label['name'],
        'color': label['color'],
        'description': label['description']
    }
    response = requests.post(label_url, headers=headers, json=data)
    if response.status_code == 201:
        print(f"✅ ラベル '{label['name']}' を作成しました")
    elif response.status_code == 422:
        print(f"⚠️ ラベル '{label['name']}' はすでに存在しています")
    else:
        print(f"❌ 作成失敗: {response.status_code} ({label['name']})")
        print(response.json())

# issue作成
for issue in issues:
    data = {
        'title': issue['title'],
        'body': issue['body'],
        'labels': labels[0]['name']
    }
    response = requests.post(issue_url, headers=headers, json=data)
    # 結果確認
    if response.status_code == 201:
        print(f"Issue作成成功: {response.json()['html_url']}")
    else:
        print(f"Issue作成失敗: {response.status_code}")
        print(response.json())
