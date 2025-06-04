import os
import sys
import requests
import yaml

# usage: python create_issues.py [container|configuration]

def main():
    if len(sys.argv) != 2:
        print("Usage: python create_issues.py [container|configuration]")
        sys.exit(1)
    target = sys.argv[1]

    # 設定ファイル読み込み
    with open(os.path.join(os.path.dirname(__file__), "issue_settings.yaml"), encoding="utf-8") as f:
        settings = yaml.safe_load(f)["settings"]
    setting = next((s for s in settings if s["name"] == target), None)
    if not setting:
        print(f"設定が見つかりません: {target}")
        sys.exit(1)

    label = setting["label"]
    issue_yaml = setting["issue_yaml"]

    # GitHub情報
    GITHUB_TOKEN = os.environ.get('GITHUB_TOKEN')
    GITHUB_REPO = os.environ.get('GITHUB_REPO')
    if not GITHUB_TOKEN or not GITHUB_REPO:
        print("GITHUB_TOKEN, GITHUB_REPO環境変数を設定してください")
        sys.exit(1)

    # YAMLからIssueリストを読み込み
    with open(os.path.join(os.path.dirname(__file__), issue_yaml), encoding="utf-8") as f:
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
            'labels': [label['name']]
        }
        response = requests.post(issue_url, headers=headers, json=data)
        if response.status_code == 201:
            print(f"Issue作成成功: {response.json()['html_url']}")
        else:
            print(f"Issue作成失敗: {response.status_code}")
            print(response.json())

if __name__ == "__main__":
    main()
