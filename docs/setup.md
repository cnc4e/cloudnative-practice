[Top](../README.md)  
前: -  
次: [CloudNativeの基礎](./cloudnative.md)

---

# 環境セットアップ

プラクティスを始める前に環境を準備します。以下の手順に従って、GitHubアカウントの作成、PATの作成、端末の準備、リポジトリの準備を行ってください。

- [環境セットアップ](#環境セットアップ)
- [GitHubの準備](#githubの準備)
  - [アカウントの作成](#アカウントの作成)
  - [PATの作成](#patの作成)
- [端末の準備](#端末の準備)
  - [各種コマンド確認](#各種コマンド確認)
    - [git](#git)
    - [aws](#aws)
    - [terraform](#terraform)
    - [kubectl](#kubectl)
    - [python](#python)
    - [docker](#docker)
    - [helm](#helm)
- [リポジトリの準備](#リポジトリの準備)
  - [空のリポジトリを作成](#空のリポジトリを作成)
  - [cnc4eのリポジトリをクローン](#cnc4eのリポジトリをクローン)
  - [自身のGitHubアカウントのリポジトリをクローン](#自身のgithubアカウントのリポジトリをクローン)
  - [(任意)レビュアーを追加](#任意レビュアーを追加)
  - [(任意)ユーザー名・パスワードの省略](#任意ユーザー名パスワードの省略)
- [プラクティスの開始](#プラクティスの開始)

# GitHubの準備
## アカウントの作成

GitHubの個人アカウントを持っていない場合は次の公式ドキュメントを参考にアカウントを作成してください。[GitHub でのアカウントの作成](https://docs.github.com/ja/get-started/start-your-journey/creating-an-account-on-github)

## PATの作成

GitHubアカウントの個人アクセストークン(PAT)を持っていない場合は次の公式ドキュメントを参考に作成してください。[GitHub での個人用アクセストークンの作成](https://docs.github.com/ja/authentication/keeping-your-account-and-data-secure/creating-a-personal-access-token)

権限は以下が最低限ついていればいいです。

- Fine-grained tokens の場合
  - Repository permissions
    - `Issues`: Read & Write
    - `Contents`: Read & Write
    - `Metadata`: Read (他の権限付けると自動でつくはず)
- Personal access tokens (classic)の場合
  - `repo`

# 端末の準備

Linuxを想定しています。Linux環境がない場合、次を参考にlinux環境を構築してください。[bastion](https://registry.terraform.io/modules/cnc4e/bastion/aws/latest)

## 各種コマンド確認

Linux環境で以下コマンドが使えることを確認してください。

### git

``` sh
git --version
```

インストールされていない場合、次を参考にインストールしてください。[Gitのインストール](https://git-scm.com/downloads)

### aws

``` sh
aws --version
```

インストールされていない場合、次を参考にインストールしてください。[AWS CLIのインストール](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)

また、CLIの設定がこれからプラクティスで使用するAWSアカウントになっているかも確認してください。

``` sh
aws sts get-caller-identity
```

`aws configure`が済んでいない場合、次を参考に設定してください。[AWS CLIの設定](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-quickstart.html)

### terraform

``` sh
terraform version
```

インストールされていない場合、次を参考にインストールしてください。[Terraformのインストール](https://developer.hashicorp.com/terraform/install)

### kubectl

``` sh
kubectl version --client
```

インストールされていない場合、次を参考にインストールしてください。[kubectlのインストール](https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/)

### python

``` sh
python --version
```

または

``` sh
python3 --version
```

python3を使用してください。
インストールされていない場合、次を参考にインストールしてください。[Pythonのインストール](https://docs.python.org/ja/3/using/unix.html#installation-steps)

### docker

``` sh
docker --version
```

インストールされていない場合、次を参考にインストールしてください。[Dockerのインストール](https://docs.docker.com/engine/install/)

### helm

``` sh
helm version
```

インストールされていない場合、次を参考にインストールしてください。[Helmのインストール](https://helm.sh/docs/intro/install/)

# リポジトリの準備

CNC4Eのリポジトリをコピーして自身のGitHubアカウントにプライベートなリポジトリを作成します。

> **なぜフォークしないのか？**  
> プラクティス用のリポジトリに間違えて機微な情報をコミットしてしまった場合の影響を抑えるためフォークではなくプライベートな新しいリポジトリを作成します。

## 空のリポジトリを作成

自身のGitHubアカウントにプライベートな空のリポジトリを作成します。以下の手順で行います。

- 自身のGitHubアカウントで[GitHub](https://github.com/)にログイン
- 左メニューから`New`を選択
  ![create-repo-1](./images/create-repo-1.png)
- 以下の情報を入力して`Create repository`をクリック
  - Repository name: `cloudnative-practice`
  - Visibility: `Private`
  ![create-repo-2](./images/create-repo-2.png)

## cnc4eのリポジトリをクローン

**cnc4e**のリポジトリをクローンします。任意のディレクトリで以下のコマンドを実行してください。

``` sh
git clone --bare https://github.com/cnc4e/cloudnative-practice.git
```

クローンしたディレクトリに移動し、自身のGitHubアカウントに新しいリポジトリを作成します。以下のコマンドを実行してください。

``` sh
cd cloudnative-practice.git
git push --mirror https://github.com/{あなたのGitHubアカウント名}/cloudnative-practice.git
Username for 'https://github.com': {あなたのGitHubアカウント名}
Password for 'https://{あなたのGitHubアカウント名}@github.com': {あなたのGitHubアカウントのPAT}
```

自身のGitHubアカウントにリポジトリを作成したら一旦クローンしたディレクトリを削除します。

``` sh
cd ..
rm -rf cloudnative-practice.git
```

## 自身のGitHubアカウントのリポジトリをクローン

自身のGitHubアカウントに作成したリポジトリを作業端末にクローンします。任意のディレクトリに移動して以下のコマンドを実行してください。

``` sh
git clone https://github.com/{あなたのGitHubアカウント名}/cloudnative-practice.git
Username for 'https://github.com': {あなたのGitHubアカウント名}
Password for 'https://{あなたのGitHubアカウント名}@github.com': {あなたのGitHubアカウントのPAT}
```

cnc4eのリポジトリをupstreamとして追加

``` sh
cd cloudnative-practice
git remote add upstream https://github.com/cnc4e/cloudnative-practice.git
```

cnc4eのリポジトリで更新があった場合、以下のコマンドで最新の状態に更新できます。

``` sh
git fetch upstream
git merge upstream/main
```

## (任意)レビュアーを追加

プラクティスは一人で進めることもできますが他の人にレビューしてもらうことでより良いコードを書くことができます。
レビュアーを追加する場合、以下の手順で行います。

- 自身のGitHubアカウントでGitHubにログイン
- 作成したリポジトリ`cloudnative-practice`のページに移動
- ``Settings``タブをクリック
  ![review-1](./images/review-1.png)
- 左側のメニューから``Collaborators``を選択
  ![review-2](./images/review-2.png)
- ``Add people``をクリック
  ![review-3](./images/review-3.png)
- レビュアーにしたいGitHubアカウント名**Find people**を入力し、``Add ``をクリック
  ![review-4](./images/review-4.png)
- 追加したレビューア宛てにGitHubから招待メールが送信されます。レビュアーはそのメールを受け取り、承認することでリポジトリにアクセスできるようになります。
  ![review-5](./images/review-5.png)  
  ![review-6](./images/review-6.png)

## (任意)ユーザー名・パスワードの省略

GitHubのリポジトリをクローンした後、毎回ユーザー名とパスワードを入力するのは面倒です。以下の手順で省略できます。
- クローンしたリポジトリのルートにある`.git`ディレクトリに移動
- `config`ファイルを開き以下のように編集します。`https://github.com...`の`//`と`github.com`の間に`{あなたのGitHubアカウント名}:{あなたのPAT}@`を追加します。

``` ini
...
[remote "origin"]
        url = https://{あなたのGitHubアカウント名}:{あなたのPAT}@github.com/{あなたのGitHubアカウント名}/cloudnative-practice.git
...
```

# プラクティスの開始

これで環境の準備が完了しました。次の章からプラクティスを開始してください。

---

[Top](../README.md)  
前: -  
次: [CloudNativeの基礎](./cloudnative.md)  
