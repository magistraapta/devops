# EC2 Terraform

Deploy an EC2 instance on AWS using Terraform with a modular architecture.

## 🏗️ Architecture

```mermaid
flowchart TB
    subgraph AWS["☁️ AWS Cloud (ap-southeast-1)"]
        subgraph VPC["🔒 VPC (10.0.0.0/16)"]
            subgraph PublicSubnet["📡 Public Subnet (10.0.1.0/24)"]
                EC2["🖥️ EC2 Instance<br/>Amazon Linux 2023<br/>t2.micro"]
                SG["🛡️ Security Group<br/>Ports: 22, 80, 443, 3000"]
            end
            RT["🔀 Route Table"]
        end
        IGW["🌐 Internet Gateway"]
    end

    Internet["🌍 Internet"] --> IGW
    IGW --> RT
    RT --> PublicSubnet
    SG --> EC2

    style AWS fill:#232F3E,color:#fff
    style VPC fill:#1a73e8,color:#fff
    style PublicSubnet fill:#4285f4,color:#fff
    style EC2 fill:#FF9900,color:#000
    style IGW fill:#7B42BC,color:#fff
    style SG fill:#34a853,color:#fff
```

## 📁 Project Structure

```
ec2-terraform/
├── main.tf                 # Root module - providers, data sources, module calls
├── variable.tf             # Input variables
├── outputs.tf              # Output values
├── terraform.tfstate       # State file (auto-generated)
└── modules/
    ├── networking/         # VPC, Subnet, Internet Gateway, Route Table
    │   ├── main.tf
    │   ├── variable.tf
    │   └── outputs.tf
    └── application/        # EC2 Instance, Security Group
        ├── main.tf
        ├── variables.tf
        └── outputs.tf
```

## 🔧 Module Overview

```mermaid
flowchart LR
    subgraph Root["📦 Root Module"]
        Main["main.tf"]
        Vars["variable.tf"]
        Out["outputs.tf"]
    end

    subgraph Networking["🌐 Networking Module"]
        VPC["VPC"]
        Subnet["Public Subnet"]
        IGW["Internet Gateway"]
        RouteTable["Route Table"]
    end

    subgraph Application["💻 Application Module"]
        EC2["EC2 Instance"]
        SecurityGroup["Security Group"]
    end

    Main --> Networking
    Main --> Application
    Networking -->|vpc_id, subnet_id| Application

    style Root fill:#f5f5f5,stroke:#333
    style Networking fill:#e3f2fd,stroke:#1976d2
    style Application fill:#fff3e0,stroke:#f57c00
```

## 📋 Prerequisites

- [Terraform](https://www.terraform.io/downloads) >= 1.0
- [AWS CLI](https://aws.amazon.com/cli/) configured with credentials
- An AWS Key Pair in the target region

## 🚀 Quick Start

### 1. Configure AWS Credentials

```bash
aws configure
```

### 2. Initialize Terraform

```bash
terraform init
```

### 3. Review the Plan

```bash
terraform plan -var="key_pair_name=YOUR_KEY_PAIR"
```

### 4. Apply the Configuration

```bash
terraform apply -var="key_pair_name=YOUR_KEY_PAIR"
```

### 5. Connect to Your Instance

```bash
ssh -i /path/to/your-key.pem ec2-user@<EC2_PUBLIC_IP>
```

## 📥 Input Variables

| Variable            | Description                                                     | Type     | Default           |
| ------------------- | --------------------------------------------------------------- | -------- | ----------------- |
| `aws_regions`       | AWS region to deploy resources                                  | `string` | `ap-southeast-1`  |
| `availability_zone` | Availability zone for the subnet                                | `string` | `ap-southeast-1a` |
| `ami_id`            | AMI ID for EC2 (auto-fetches Amazon Linux 2023 if not provided) | `string` | `null`            |
| `key_pair_name`     | Name of the AWS key pair for SSH access                         | `string` | _Required_        |

## 📤 Outputs

| Output          | Description                           |
| --------------- | ------------------------------------- |
| `ec2_public_ip` | Public IP address of the EC2 instance |

## 🔐 Security Group Rules

| Port | Protocol | Description         |
| ---- | -------- | ------------------- |
| 22   | TCP      | SSH access          |
| 80   | TCP      | HTTP traffic        |
| 443  | TCP      | HTTPS traffic       |
| 3000 | TCP      | Node.js application |

## 🛠️ Common Commands

```bash
# Initialize Terraform
terraform init

# Format code
terraform fmt -recursive

# Validate configuration
terraform validate

# Plan changes
terraform plan -var="key_pair_name=YOUR_KEY"

# Apply changes
terraform apply -var="key_pair_name=YOUR_KEY"

# Destroy all resources
terraform destroy -var="key_pair_name=YOUR_KEY"

# Show current state
terraform show

# List all resources
terraform state list
```

## 📝 Notes

- The AMI is automatically fetched using a data source (latest Amazon Linux 2023)
- All resources are created in the `ap-southeast-1` region by default
- The EC2 instance is launched in a public subnet with a public IP
- Remember to destroy resources when not in use to avoid charges

## 📜 License

MIT License
