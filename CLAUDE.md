# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a **Cloud-Native Practice Repository** - a Japanese educational project that teaches cloud-native technologies through structured, issue-based learning exercises. The repository provides hands-on practice with Git, Terraform, Kubernetes, and CI/CD using AWS services, particularly EKS.

## Architecture and Structure

### Core Application Components
- **Backend**: Node.js Express API (`codes/backend/app/`)
- **Frontend**: React application with Nginx (`codes/frontend/app/`)
- **Infrastructure**: Terraform modules for AWS resources
- **Kubernetes**: Complete K8s manifests and configurations

### Key Directories
- `/codes/` - Working directory where students create their Infrastructure as Code (Terraform) and Kubernetes manifests
- `/example/` - Reference implementations and answer examples (students should not modify these)
- `/docs/` - Comprehensive learning materials and practice guides
- `/scripts/` - Automation tools for GitHub issue creation and practice orchestration

## Development Workflows

### Git Commit Conventions
**IMPORTANT**: All commit messages must include the issue number at the beginning:
- Format: `#<issue-number> <commit message>`
- Extract issue number from branch name (e.g., branch `12-gracefulshutdown` → issue `#12`)
- Example: `#12 graceful shutdownの実装を追加`

### Issue Management
Create GitHub issues for practice exercises using:
```bash
cd scripts
python create_issues.py [container|configuration|o11y]
```
Requires `GITHUB_TOKEN` and `GITHUB_REPO` environment variables.

### Infrastructure Management
Students create Terraform modules in `/codes/` directory following these patterns:
```bash
# Standard Terraform workflow in /codes/<module-name>/
terraform init
terraform plan
terraform apply
```

Key Terraform conventions:
- Students create modules like `/codes/eks/`, `/codes/ecr/`, `/codes/network/`
- State backend: S3 + DynamoDB (reference in `/example/tfbackend/`)
- for `/example/` 
  - File patterns: `_versions.tf`, `_locals.tf`, `_data.tf`
  - Consistent tagging: `cn-practice` project, `mori` owner
  - Region: `ap-northeast-2` (Seoul)
- **Reference**: Check `/example/` for implementation examples when stuck

### Container Development
Students work with applications in `/codes/backend/app/` and `/codes/frontend/app/`:
- Multi-stage Docker builds
- ECR image registry (students create ECR module in `/codes/ecr/`)
- Kubernetes deployments with health checks
- Students create K8s manifests in `/codes/backend/k8s/` and `/codes/frontend/k8s/`

### Kubernetes Operations
```bash
# Standard kubectl commands for verification
kubectl get pods
kubectl describe deployment <name>
kubectl logs <pod-name>
```

Key K8s patterns:
- Students create Deployments with resource limits and health checks
- Services with proper port configurations  
- **Reference**: Check `/example/` directories for K8s manifest examples
- RBAC configurations for CI/CD access

## Technology Stack

**Core Technologies:**
- **AWS**: EKS, ECR, VPC, S3, CloudWatch
- **Terraform**: ~> 5.1 AWS provider
- **Kubernetes**: Via EKS with standard manifests
- **CI/CD**: GitHub Actions + ArgoCD
- **Languages**: Node.js (backend), React (frontend), Python (automation)

**Naming Conventions:**
- Project resources tagged with `cn-practice`
- Owner tagged as `mori`
- Consistent module naming in Terraform
- ALB Controller actually deploys NLB (important correction made in documentation)

## Practice Flow

The learning path follows this progression:
1. **Environment Setup** (`docs/setup.md`)
2. **Cloud-Native Basics** (`docs/cloudnative.md`) 
3. **Configuration Management** (`docs/configuration.md`) - Terraform
4. **Container** (`docs/container.md`) - Docker + Kubernetes
5. **CI/CD** (`docs/cicd.md`) - GitHub Actions + ArgoCD
6. **Observability** (`docs/observability.md`) - CloudWatch monitoring

## Common Tasks

### Creating New Practice Issues
Use the Python script in `/scripts/` with appropriate YAML configuration files.

### Infrastructure Updates
Students create and modify Terraform modules in `/codes/` directory (e.g., `/codes/eks/`, `/codes/ecr/`). Reference `/example/` for implementation guidance.

### Application Changes
Update source code in `/codes/backend/app/` and `/codes/frontend/app/`. Create Kubernetes manifests in `/codes/backend/k8s/` and `/codes/frontend/k8s/`.

### Documentation Updates
Modify practice guides in `/docs/` directory, maintaining the structured learning progression.

## Adding New Practice

新しいプラクティスを追加する際は、以下の雛形に従って一貫性のある構造で作成してください。

- プロンプトで与えられた内容を基に、以下のようなYAML形式で新しいプラクティスのissueを作成します。

```yaml
issues:
  - title: プラクティスのタイトル
    body: |
      新プラクティスの概要を1～2文で記載します。

      # 課題や必要性
      - このプラクティスがなぜ必要か、どんなリスクがあるかを記載
      
      # 解決策
      - 課題や必要性に対する解決策の選択肢を挙げる
      - 解決策の内、今回はどの選択肢を採用するか理由と共に明記します。
      
      # 解決策の説明
      - 選択した解決策の簡単な説明
      - 解決策を実装するための手順を箇条書きで記載します。
      
      # プラクティス
      - 生徒が実際に行うべき内容を箇条書きで記載します。
      - さらに発展的なプラクティスがあれば、最後にその内容を記載します。
```

以下は新しいプラクティスの例です。

```yaml
  - title: ノードの暗号化
    body: |
      EKSのノードは一時的なものとして使うことが多いですが、一時的に機密情報を格納することもあります。そのため、ノードの暗号化を行うことで、機密情報の漏洩リスクを低減できます。

      # ノードの暗号化の必要性
      - ノードのEBSボリュームに機密情報が格納されることがある
      - 物理的な不正アクセスにより、機密情報が漏洩するリスクがある
      - ノードのEBSボリュームを暗号化することで、機密情報の漏洩リスクを低減できる 
      
      # 解決策
      - EBSデフォルトの暗号化を有効にし、新規に作成されるEBSボリュームを自動的に暗号化する
      - （Fargate、EKS AutoModeの場合）ノードディスクはデフォルトで暗号化される
      
      本プラクティスでは EKS AutoMode を採用しているため、EKS Automode におけるノードの暗号化を確認します。

      # EKS AutoModeのノード暗号化
      - EKS AutoModeでは、ノードのEBSボリュームがデフォルトで暗号化される
      - 暗号化はAWS KMSを使用して行われ、デフォルトではAWSマネージドの`aws/ebs`キーが使用される
      - `nodeclass`リソースの`spec.ephemeralStorage.kmsKeyID`で任意のKMSキーを指定することも可能
      
      ## CMKを使ったノードのEBSボリュームの暗号化

      - KMSキーを作成する
        - リソースポリシーで`EKSのクラスターロール`および`ノードロール`からのアクセスを許可する
        - `EKSのクラスターロール`および`ノードロール`にもKMSを使用する権限を付与する
      - `nodeClass`および`nodePool`を新たに作成
        - `nodeClass`の`spec.ephemeralStorage.kmsKeyID`にカスタマーKMSキーを指定

      # プラクティス
      
      - EKS AutoModeのノード暗号化を確認する
        - EKS AutoModeのワーカーノードを確認し、EBSボリュームが`aws/ebs`キーで暗号化されていることを確認する

      ## 更に発展的なプラクティス
      このプラクティスは余裕がなければやらなくてもいいです。

      CMKを使いノードのEBSボリュームを暗号化する。
      新規にnodeclassおよびnodepoolを作成し、ノードのEBSボリュームをカスタマーKMSキーで暗号化する。

      - ノード暗号化用のカスタマーKMSキーを作成する
      - `nodeClass`および`nodePool`を新たに作成する
        - `nodeClass`の`spec.ephemeralStorage.kmsKeyID`にカスタマーKMSキーを指定する
        - `nodePool`にはノードに任意のラベルを付与する
      - 作成し`nodePool`でPodを起動させる。nodeSelector等でノードに付与した任意のラベルを指定するといい
      - 作成されたノードを確認しEBSがCMKで暗号化されていることを確認する
```

### 命名規則とパターン

- **プロジェクト共通**: タグは `cn-practice` + `mori`、リージョンは `ap-northeast-2`
- **ファイル命名**: アンダースコア接頭辞 (`_versions.tf`, `_locals.tf`) + リソース名ファイル
- **セキュリティ**: 全K8sマニフェストで非root実行とreadonly filesystem
- **段階的学習**: 概念説明 → 実践 → 応用の構造を維持

## Important Notes

- This is primarily a **learning repository** - prioritize educational clarity over production optimization
- All documentation is in **Japanese** - maintain consistency
- **ALB Controller** actually deploys **NLB** - this has been corrected in documentation
- Repository uses **issue-driven development** for practice exercises
- Students work in `/codes/` directory; `/example/` contains reference answers (do not modify)
- **AWS Documentation**: For AWS-related questions and documentation lookup, use the MCP server: `aws-docs` for accurate and up-to-date information
- **Terraform Documentation**: For Terraform-related questions and documentation lookup, use the MCP server: `terraform` for accurate provider and module information