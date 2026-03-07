# ❧ state-locked-workspaces

A modular Terraform project designed to provision AWS EC2 infrastructure across multiple environments (Development and Production) using custom VPC networking and remote state management with S3 and DynamoDB state locking.

This repository demonstrates production-grade Terraform practices, including:

*   Modular infrastructure design
*   Remote state storage
*   State locking
*   Environment separation
*   Reusable modules
*   Infrastructure as Code (IaC) best practices

## ◈ Table of Contents

- [Project Overview](#-project-overview)
- [Architecture](#-architecture)
- [Project Structure](#-project-structure)
- [Environments](#-environments)
  - [Development Environment](#development-environment)
  - [Production Environment](#production-environment)
- [Terraform Modules](#-terraform-modules)
  - [Networking Module](#-networking-module)
  - [Web Server Module](#-web-server-module)
- [Remote State Management](#--remote-state-management)
  - [S3 Backend](#s3-backend)
  - [DynamoDB State Locking](#dynamodb-state-locking)
- [Prerequisites](#-prerequisites)
- [AWS Configuration](#--aws-configuration)
- [Deployment Guide](#--deployment-guide)
  - [Clone the Repository](#-clone-the-repository)
  - [Deploy State Locking Infrastructure](#-deploy-state-locking-infrastructure)
  - [Deploy Development Environment](#-deploy-development-environment)
- [Example Deployment Workflow](#example-deployment-workflow)
- [Future Improvements](#-future-improvements)
- [Contributing](#-contributing)
- [License](#-license)
- [Author](#-author)

## ◈ Project Overview

This project provisions AWS infrastructure using Terraform modules and environment-based configurations. The system is designed to:

*   Deploy EC2 instances using reusable Terraform modules
*   Support multiple environments such as development and production
*   Store Terraform state in AWS S3
*   Prevent concurrent Terraform executions using DynamoDB state locking
*   Maintain clean, reusable infrastructure code

## ◈ Architecture

The infrastructure architecture follows a modular layered design:

```text
Terraform Root
│
├── Global Infrastructure
│   ├── S3 Backend
│   └── DynamoDB State Locking
│
├── Environment Layer
│   ├── Development
│   └── Production
│
└── Infrastructure Modules
    ├── Networking (VPC)
    └── Web Server (EC2)
```

### Key Components

| Component             | Purpose                            |
|-----------------------|------------------------------------|
| **S3 Backend**         | Stores Terraform state remotely    |
| **DynamoDB Table**    | Prevents concurrent Terraform runs |
| **Networking Module** | Creates custom VPC infrastructure  |
| **Web Server Module** | Creates EC2 instances              |
| **Environment Layer** | Separates dev and prod deployments |

---

# ◈ Project Structure
```text
MULTI-ENV-PROJ
│
├── environments
│   ├── dev
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   ├── providers.tf
│   │   └── terraform.tf
│   │
│   └── prod
│       ├── main.tf
│       ├── outputs.tf
│       ├── providers.tf
│       └── terraform.tf
│
├── global
│   └── state-locking
│       ├── dynamodb.tf
│       ├── s3.tf
│       └── variables.tf
|
├── modules
│   ├── networking
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   │
│   └── web-server
│       ├── main.tf
│       ├── outputs.tf
│       └── variables.tf
│
├── .gitignore
├── LICENSE
└── README.md
```


---

# ◈ Environments

This project supports multiple infrastructure environments.

## Development Environment

Path: environments/dev


Used for:

- Testing infrastructure
- Development deployments
- Infrastructure experimentation

Runs modules:

- Networking
- Web Server

---

## Production Environment

Path: environments/prod


Used for:

- Production workloads
- Stable infrastructure
- Real application deployments

This environment typically contains stricter configurations such as:

- Larger instance sizes
- Production networking
- Security configurations

---

# ◈ Terraform Modules

Modules provide **reusable infrastructure components**.

---

## 🔸 Networking Module

Path: modules/networking


### Purpose

Creates a **custom VPC networking stack**.

### Resources Created

- VPC
- Subnets
- Internet Gateway
- Route Tables
- Route Table Associations

### Inputs

Example variables:

| Variable | Description |
|--------|--------|
| `vpc_cidr` | CIDR block for VPC |
| `subnet_cidr` | Subnet range |
| `availability_zone` | AWS availability zone |

### Outputs

| Output | Description |
|------|------|
| `vpc_id` | ID of created VPC |
| `subnet_id` | ID of created subnet |

---

## 🔸 Web Server Module

Path: modules/web-server


### Purpose

Creates an **EC2 instance inside the VPC**.

### Resources Created

- EC2 instance
- Security group
- Instance networking

### Inputs

| Variable | Description |
|--------|--------|
| `ami_id` | AMI used for EC2 |
| `instance_type` | EC2 instance type |
| `subnet_id` | Subnet where instance is deployed |

### Outputs

| Output | Description |
|------|------|
| `instance_id` | EC2 instance ID |
| `public_ip` | Public IP of instance |

---

# ◈  Remote State Management

Terraform state is stored remotely to allow **team collaboration and safe infrastructure updates**.

---

## S3 Backend

The Terraform state file is stored in an **AWS S3 bucket**.

Benefits:

- Persistent storage
- Versioning support
- Team collaboration
- Secure access control

Example configuration:

```hcl
terraform {
  backend "s3" {
    bucket = "terraform-state-bucket"
    key    = "state/terraform.tfstate"
    region = "us-east-1"
  }
}
```

## DynamoDB State Locking

A DynamoDB table is used to prevent multiple users from modifying Terraform state simultaneously.

Benefits:

- Prevents state corruption

- Ensures safe concurrent Terraform runs

- Locks state during apply operations

Example configuration:

```hcl
terraform {
resource "aws_s3_bucket" "prj1-terra" {
  bucket = var.bucket_name
  force_destroy = true
  tags = {
    Name   = var.bucket_name
  }
}
```

# ◈ Prerequisites

Before using this project, ensure the following tools are installed:

Before using this project, ensure the following tools are installed:

| Tool	| Version |
|-------|-----|
Terraform |	>= 1.0
AWS CLI	| Latest
Git	| Latest

# ◈  AWS Configuration

Configure AWS credentials before running Terraform.
```
aws configure
```
Provide:
```
AWS Access Key
AWS Secret Key
Region
Output format
```

# ◈  Deployment Guide
## 🔸 Clone the Repository

```
git clone https://github.com/Shesha-Sai-999/state-locked-workspaces.git
cd state-locked-workspaces
```
## 🔸 Deploy State Locking Infrastructure

Navigate to the global state locking directory, Initialize and run Terraform:
```bash
cd global/state-locking
terraform init
terraform plan
terraform apply
```
This will create:

- S3 bucket

- DynamoDB locking table

## 🔸 Deploy Development Environment

Navigate to dev environment and launch the environment:
```bash

cd environments/dev
terraform init
terraform plan
terraform apply
```
# Example Deployment Workflow
```text
Step 1: Deploy global infrastructure
                ↓
          Create S3 + DynamoDB
                ↓
Step 2: Deploy environment
                ↓
         Call Terraform modules
                ↓
             Create VPC
                ↓
        Deploy EC2 instance
```        


# ◈ Future Improvements

Possible enhancements:

- Add Auto Scaling Groups

- Add Load Balancer

- Add Terraform Workspaces

- Add CI/CD pipeline (GitHub Actions)

- Add Monitoring with CloudWatch

- Add Security hardening

# ◈ Contributing

Contributions are welcome.

Steps:

- Fork the repository

- Create a feature branch

- Commit your changes

- Submit a pull request

# ◈ License

This project is licensed under the Apache-2.0 License.

# ◈ Author

Shesha Sai Geethri
