# 🚀 Two-Tier DevSecOps Application Deployment on AWS

> 🔥 **Production-Ready DevSecOps Project | Resume + GitHub Portfolio Ready**

---

## 📌 Project Overview

This project demonstrates a **complete DevSecOps pipeline** for deploying a **two-tier application** on AWS using modern tools and best practices.

### 🧠 What This Project Covers

* Infrastructure as Code using Terraform
* Secure CI/CD using GitHub Actions
* Containerization using Docker
* Integrated Security (SonarQube, Snyk, Trivy)
* OIDC-based authentication (no static AWS keys)

---

## 🏗️ Architecture Diagram (Draw.io Style)

```
                ┌──────────────────────────────┐
                │           Internet           │
                └──────────────┬───────────────┘
                               │
                        ┌──────▼──────┐
                        │  Frontend   │
                        │  EC2 (Docker)│
                        │ Public Subnet│
                        └──────┬──────┘
                               │ (HTTP:5000)
                        ┌──────▼──────┐
                        │  Backend    │
                        │  EC2 (Docker)│
                        │ Private Subnet│
                        └──────────────┘

         ┌──────────────────────────────────────────┐
         │                AWS VPC                   │
         │  - Public Subnet                        │
         │  - Private Subnet                       │
         │  - Security Groups                      │
         └──────────────────────────────────────────┘

         ┌──────────────────────────────────────────┐
         │ Terraform Backend                        │
         │  - S3 (State Storage)                    │
         │  - DynamoDB (State Locking)              │
         └──────────────────────────────────────────┘

         ┌──────────────────────────────────────────┐
         │ GitHub Actions CI/CD                     │
         │  - Build → Scan → Push → Deploy          │
         │  - OIDC Authentication                   │
         └──────────────────────────────────────────┘
```

---

## ⚙️ Tech Stack

| Category   | Tools Used                        |
| ---------- | --------------------------------- |
| Cloud      | AWS (EC2, VPC, IAM, S3, DynamoDB) |
| IaC        | Terraform                         |
| Containers | Docker                            |
| CI/CD      | GitHub Actions                    |
| Security   | SonarQube, Snyk, Trivy            |

---

## 📁 Project Structure

```
.
├── .github/
│   └── workflows/
│       └── ci-cd.yml
├── .vscode/
├── app/
│   ├── backend/
│   │   └── (Flask application code)
│   └── frontend/
│       └── (Frontend application code)
├── docker-compose.yml
├── terraform-files/
│   ├── backend/
│   │   └── (Backend-specific Terraform configs if any)
│   ├── compute/
│   │   ├── .terraform/
│   │   ├── .terraform.lock.hcl
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   └── core/
│       ├── .terraform/
│       ├── .terraform.lock.hcl
│       ├── backend.tf
│       ├── main.tf
│       ├── variables.tf
│       └── outputs.tf
├── .gitignore
├── sonar-project.properties
```

### 📌 Structure Explanation

* **.github/workflows/** → Contains CI/CD pipelines (GitHub Actions)
* **app/backend/** → Flask backend application
* **app/frontend/** → Frontend application
* **docker-compose.yml** → Local multi-container setup (frontend + backend)

### Terraform Breakdown (Important)

* **terraform-files/core/**

  * Creates foundational infrastructure:

    * VPC
    * Subnets (public & private)
    * IAM roles
    * Backend configuration (S3 + DynamoDB)

* **terraform-files/compute/**

  * Handles compute resources:

    * EC2 instances (frontend + backend)
    * Security groups
    * Networking rules

* **terraform-files/backend/**

  * (Optional/Extendable)
  * Can be used for app-specific infra (DB, services, etc.)

---

## 🚀 Features

✅ Two-tier secure architecture (public + private subnet)
✅ Fully automated CI/CD pipelines
✅ Security scanning integrated (shift-left approach)
✅ Parallel deployments using matrix strategy
✅ Parameterized deployments (dev/staging/prod)
✅ OIDC authentication (no hardcoded AWS credentials)

---

## 🔄 CI/CD Pipelines

### 1️⃣ Simple DevSecOps Pipeline

```
Code → Build → Scan → Push → Deploy
```

### 2️⃣ Parameterized Pipeline

```yaml
on:
  workflow_dispatch:
    inputs:
      environment:
        description: "dev/staging/prod"
        required: true
```

### 3️⃣ Matrix Parallel Pipeline

```yaml
strategy:
  matrix:
    env: [dev, staging]
```

---

## 🔐 Security Integration

| Tool      | Purpose                        |
| --------- | ------------------------------ |
| SonarQube | Code Quality & Static Analysis |
| Snyk      | Dependency Vulnerability Scan  |
| Trivy     | Container Image Scan           |

---

## 🔑 OIDC Authentication Flow

```
GitHub Actions → OIDC Token → AWS IAM Role → Temporary Credentials
```

✔ No AWS access keys required
✔ More secure and production-ready

---

## 🛠️ Setup Instructions

### 1. Clone Repository

```bash
git clone <your-repo-url>
cd project
```

### 2. Initialize Terraform

```bash
terraform init
terraform plan
terraform apply
```

### 3. Configure GitHub Secrets

* AWS Role ARN
* Docker credentials
* Snyk token

### 4. Trigger Pipeline

* Use GitHub Actions → Run workflow

---

## ⚠️ Common Issues & Fixes

### Terraform State Lock Issue

* ❌ Cause: Parallel pipeline
* ✅ Fix: Separate backend per environment

### Backend Not Reachable

* Check Security Group rules
* Ensure correct port (5000)

### Docker Image Not Updating

* Use unique tags or commit SHA

---

## ✅ Best Practices

* Separate environments (dev/staging/prod)
* Use remote state (S3 + DynamoDB)
* Avoid static credentials (use OIDC)
* Implement security scans early

---

## 🚀 Future Enhancements

* Kubernetes (EKS)
* GitOps (ArgoCD)
* Monitoring (Prometheus + Grafana)
* Auto Scaling

---

## 📈 Resume Highlights

* Designed and deployed a **two-tier cloud architecture** on AWS using Terraform
* Built **end-to-end CI/CD pipelines** with GitHub Actions
* Integrated **DevSecOps tools (SonarQube, Snyk, Trivy)** for security scanning
* Implemented **OIDC-based authentication**, eliminating static credentials
* Enabled **parallel deployments using matrix strategy**

---

## 🧠 Key Learnings

* Real-world DevSecOps implementation
* Infrastructure automation
* Secure CI/CD practices
* Cloud networking and debugging

---

## ⭐ Final Note

This project is designed to simulate a **real production DevSecOps workflow**, making it highly valuable for:

* DevOps Engineers
* Cloud Engineers
* SRE Roles

---

💡 *If this helped you, consider giving the repo a ⭐*
