import os
import requests

# 設定
GITHUB_TOKEN = os.environ.get('GITHUB_TOKEN')
GITHUB_REPO = os.environ.get('GITHUB_REPO')
# REPO_OWNER = os.environ.get('REPO_OWNER')
# REPO_NAME = os.environ.get('REPO_NAME')

# 作成したいラベルの定義（複数対応）
labels = [
    {
        'name': '構成管理',
        'color': '1f77b4',
        'description': 'インフラや設定の管理'
    },
    {
        'name': 'コンテナ',
        'color': 'ff7f0e',
        'description': 'コンテナ技術関連'
    },
    {
        'name': 'CI/CD',
        'color': '2ca02c',
        'description': '継続的インテグレーション・デリバリー'
    },
    {
        'name': 'オブザーバビリティ',
        'color': '9467bd',
        'description': '監視・可観測性'
    }
]

# APIエンドポイント
url = f'https://api.github.com/repos/{GITHUB_REPO}/labels'

# ヘッダー
headers = {
    'Authorization': f'token {GITHUB_TOKEN}',
    'Accept': 'application/vnd.github.v3+json'
}

# ラベルごとに作成リクエスト
for label in labels:
    data = {
        'name': label['name'],
        'color': label['color'],
        'description': label['description']
    }
    response = requests.post(url, headers=headers, json=data)
    if response.status_code == 201:
        print(f"✅ ラベル '{label['name']}' を作成しました")
    elif response.status_code == 422:
        print(f"⚠️ ラベル '{label['name']}' はすでに存在しています")
    else:
        print(f"❌ 作成失敗: {response.status_code} ({label['name']})")
        print(response.json())
