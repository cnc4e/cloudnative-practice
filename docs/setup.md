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
  - [cnc4eのリポジトリをクローン](#cnc4eのリポジトリをクローン)
  - [リポジトリのプライベート化](#リポジトリのプライベート化)
  - [(任意)レビュアーを追加](#任意レビュアーを追加)
  - [自身のGitHubアカウントのリポジトリをクローン](#自身のgithubアカウントのリポジトリをクローン)
- [プラクティスの開始](#プラクティスの開始)

# GitHubの準備
## アカウントの作成

GitHubの個人アカウントを持っていない場合は次の公式ドキュメントを参考にアカウントを作成してください。[GitHub でのアカウントの作成](https://docs.github.com/ja/get-started/start-your-journey/creating-an-account-on-github)

## PATの作成

GitHubの個人アクセストークン(PAT)を作成します。次の公式ドキュメントを参考に作成してください。[GitHub での個人用アクセストークンの作成](https://docs.github.com/ja/authentication/keeping-your-account-and-data-secure/creating-a-personal-access-token)

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
## cnc4eのリポジトリをクローン

> **なぜフォークしないのか？**  
> プラクティス用のリポジトリに間違えて機微な情報をコミットしてしまった場合の影響を抑えるためフォークではなくプライベートな新しいリポジトリを作成します。

cnc4eのリポジトリをクローンします。任意のディレクトリで以下のコマンドを実行してください。

``` sh
git clone --bare https://github.com/cnc4e/cloudnative-practice.git
```

クローンしたディレクトリに移動し、自身のGitHubアカウントに新しいリポジトリを作成します。以下のコマンドを実行してください。

``` sh
cd cloudnative-practice
git push --mirror https://github.com/{あなたのGitHubアカウント名}/cloudnative-practice.git
```

自身のGitHubアカウントにリポジトリを作成したら一旦クローンしたディレクトリを削除します。

``` sh
cd ..
rm -rf cloudnative-practice
```

## リポジトリのプライベート化

自身のGitHubアカウントに作成したリポジトリをプライベートに設定します。以下の手順で行います。

- 自身のGitHubアカウントで[GitHub](https://github.com/)にログイン
- 作成したリポジトリ`cloudnative-practice`のページに移動
- ``Settings``タブをクリック
- 左側のメニューから``General``を選択
- ``Danger Zone``セクションまでスクロール
- ``Change repository visibility``をクリック
- ``Private``を選択し、確認のためにリポジトリ名を入力
- ``I understand the consequences, change repository visibility``をクリック

## (任意)レビュアーを追加

プラクティスは一人で進めることもできますが他の人にレビューしてもらうことでより良いコードを書くことができます。
レビュアーを追加する場合、以下の手順で行います。

- 自身のGitHubアカウントでGitHubにログイン
- 作成したリポジトリ`cloudnative-practice`のページに移動
- ``Settings``タブをクリック
- 左側のメニューから``Collaborators and teams``を選択
- ``Add people``をクリック
- レビュアーにしたいGitHubアカウント名を入力し、``Add``をクリック

## 自身のGitHubアカウントのリポジトリをクローン

自身のGitHubアカウントに作成したリポジトリを作業端末にクローンします。任意のディレクトリに移動して以下のコマンドを実行してください。

``` sh
git clone https://github.com/{あなたのGitHubアカウント名}/cloudnative-practice.git
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

# プラクティスの開始

これで環境の準備が完了しました。次の章からプラクティスを開始してください。

---

[Top](../README.md)  
前: -  
次: [CloudNativeの基礎](./cloudnative.md)  
