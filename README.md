# 🐳 Whale Cloud Infrastructure

🚀 Production-like AWS infrastructure using Terraform and Docker

---

## 📌 About The Project

**Whale Cloud Infrastructure – Production-like AWS setup with Terraform and Docker**

This project demonstrates a real-world cloud infrastructure using **AWS, Terraform, Docker, and Nginx**.

It provisions a fully working environment where:
- A containerized application is deployed on EC2 instances
- Traffic is distributed via an **AWS Application Load Balancer**
- Each instance runs **Docker containers with internal load balancing (Nginx)**

The goal of this project was to simulate a **production-ready DevOps architecture** using Infrastructure as Code.

---

## 🏗️ Architecture Overview

- 🌐 **AWS VPC**
  - Public subnets (ALB)
  - Private subnets (EC2 instances)
  - Database subnets (prepared for future use)

- ⚖️ **Load Balancing**
  - AWS Application Load Balancer (external traffic)
  - Nginx (internal container-level load balancing)

- 🖥️ **Compute**
  - EC2 instances (one per AZ)
  - Docker + Docker Compose setup via `user_data`

- 📦 **Container Registry**
  - AWS ECR (stores Docker images)

- 🔐 **Security**
  - IAM Role for EC2 → ECR access
  - Security Groups for controlled traffic

---

## 🧱 Architecture Flow

```
Internet
   ↓
AWS ALB (port 80)
   ↓
EC2 instances (2 AZ)
   ↓
Nginx (Docker)
   ↓
2x App containers (.NET)
```

---

## ✨ Features

- ✅ Infrastructure as Code with Terraform
- ✅ Multi-AZ deployment (high availability)
- ✅ Dockerized .NET 8 application
- ✅ AWS ECR integration
- ✅ Automated EC2 setup using `user_data`
- ✅ Application Load Balancer with health checks
- ✅ Nginx reverse proxy + load balancing
- ✅ Scalable architecture pattern

---

## 🛠️ Tech Stack

- **AWS**
  - VPC
  - EC2
  - ALB (Application Load Balancer)
  - ECR
  - IAM

- **Infrastructure**
  - Terraform

- **Containers**
  - Docker
  - Docker Compose
  - Nginx

- **Backend**
  - ASP.NET Core (.NET 8)

---

## 🚀 Getting Started

### 1️⃣ Prerequisites

- AWS Account
- Terraform ≥ 1.3
- Docker (for building images)
- AWS CLI configured

---

### 2️⃣ Clone the repository

```bash
git clone https://github.com/your-username/aws-terraform-docker-infrastructure-project.git
cd aws-terraform-docker-infrastructure-project
```

---

### 3️⃣ Configure variables

Create a `terraform.tfvars` file:

```hcl
region       = "eu-central-1"
ecr_repo_url = "<your-account-id>.dkr.ecr.eu-central-1.amazonaws.com/whale-app"
```

---

### 4️⃣ Deploy infrastructure

```bash
terraform init
terraform apply
```

---

### 5️⃣ Access the application

After deployment:

```bash
terraform output alb_dns
```

Then open in browser:

```
http://<alb_dns>
```

---

## 🐳 Application

A simple .NET API that returns:

```
Hello from Whale container! <container-id>
```

Used to demonstrate:
- Container scaling
- Load balancing behavior

---

## 🔐 Security Notes

- Terraform state files are excluded from Git
- No secrets are committed
- IAM roles are used instead of credentials
- SSH access is only for debugging purposes

---

## 📈 Future Improvements

### ☁️ AWS & Infrastructure
- [ ] HTTPS support using ACM + ALB
- [ ] Auto Scaling Group for EC2 instances
- [ ] CloudWatch monitoring and logging

### 🗄️ Database Layer
- [ ] Connect application to PostgreSQL database
- [ ] Deploy AWS RDS (Multi-AZ) for high availability
- [ ] Alternative: self-hosted PostgreSQL on EC2

### ⚙️ Automation & Serverless
- [ ] AWS Lambda function to populate database with sample data
- [ ] Lambda function to collect metrics from instances
- [ ] Store aggregated reports in S3

### 🔄 CI/CD & Deployment
- [ ] CI/CD pipeline using GitHub Actions
- [ ] Automated Docker build & push to ECR
- [ ] Blue/Green deployment strategy

### 📊 Advanced Features
- [ ] Request counter endpoint in application
- [ ] Centralized reporting (S3 + Lambda)

---

## 👨‍💻 Developer

**Ákos Bukovinszki**  
https://github.com/bukovinszkiakos

---

## 🛡️ License

MIT License

---

<p align="right">(<a href="#top">Back to top</a>)</p>
