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

## Important Notes

- This is primarily a **learning repository** - prioritize educational clarity over production optimization
- All documentation is in **Japanese** - maintain consistency
- **ALB Controller** actually deploys **NLB** - this has been corrected in documentation
- Repository uses **issue-driven development** for practice exercises
- Students work in `/codes/` directory; `/example/` contains reference answers (do not modify)
- **AWS Documentation**: For AWS-related questions and documentation lookup, use the MCP server: `aws-docs` for accurate and up-to-date information
- **Terraform Documentation**: For Terraform-related questions and documentation lookup, use the MCP server: `terraform` for accurate provider and module information