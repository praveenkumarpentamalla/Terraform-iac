# **Terraform: Infrastructure as Code (IaC) Tool**

## **Table of Contents**
1. [Introduction to Terraform](#1-introduction-to-terraform)
2. [Why Automate Infrastructure?](#2-why-automate-infrastructure)
3. [What is Terraform?](#3-what-is-terraform)
4. [History of Terraform](#4-history-of-terraform)
5. [Installing Terraform](#5-installing-terraform)
6. [Basic Terraform Commands](#6-basic-terraform-commands)
7. [Writing Terraform Configuration](#7-writing-terraform-configuration)
8. [Variables in Terraform](#8-variables-in-terraform)
9. [State Management](#9-state-management)
10. [Targeting Specific Resources](#10-targeting-specific-resources)
11. [Best Practices](#11-best-practices)
12. [Summary](#12-summary)

---

## **1. Introduction to Terraform**

Terraform is an **Infrastructure as Code (IaC)** tool used to automate the creation, modification, and destruction of cloud infrastructure. It allows you to define infrastructure using code, which can be versioned, reused, and shared.

### **Key Concepts:**
- **Infrastructure**: Resources like EC2 instances, S3 buckets, VPCs, load balancers, etc.
- **Automation**: Instead of manually creating resources, you write code to define them.
- **Reusability**: Code can be reused across multiple environments (e.g., dev, test, prod).

---

## **2. Why Automate Infrastructure?**

### **Manual Infrastructure Creation:**
- **Time-consuming**: Creating resources manually takes hours.
- **Error-prone**: Human errors are common (e.g., forgetting security groups, key pairs).
- **Not scalable**: Hard to manage multiple clients/environments.

### **Automation with Terraform:**
- **Time-saving**: Create infrastructure in minutes.
- **Consistency**: Avoid mistakes by reusing code.
- **Scalability**: Easily manage multiple clients/environments.
- **Tracking**: Terraform tracks resources via state files.

---

## **3. What is Terraform?**

- **Tool**: Used for infrastructure automation.
- **Free and Open Source**: No cost to use (though recent changes may lead to alternatives like OpenTofu).
- **Platform Independent**: Works on Linux, Windows, macOS.
- **Cloud Agnostic**: Supports AWS, Azure, GCP, and more.
- **Language**: Uses **HCL (HashiCorp Configuration Language)**.

### **Advantages:**
- **Reusable Code**: Write once, use multiple times.
- **Dry Run**: Preview changes with `terraform plan`.
- **Parallel Execution**: Creates resources simultaneously.
- **State Management**: Tracks resource status.

---

## **4. History of Terraform**

- **2011**: Mitchell Hashimoto faced challenges automating multi-cloud infrastructure.
- **2014**: Terraform was officially released.
- **Ownership**: Developed by HashiCorp.
- **Recent Trend**: Movement towards OpenTofu due to licensing changes.

---

## **5. Installing Terraform**

### **On Linux (EC2 Instance):**
1. Update packages:
   ```bash
   sudo yum update -y
   ```
2. Install Terraform:
   ```bash
   sudo yum install -y yum-utils
   sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo
   sudo yum -y install terraform
   ```
3. Verify installation:
   ```bash
   terraform --version
   ```

### **On Windows:**
- Download the binary from the [official website](https://www.terraform.io/downloads.html).
- Add Terraform to your PATH.

---

## **6. Basic Terraform Commands**

1. **`terraform init`**: Initializes the working directory and downloads provider plugins.
2. **`terraform plan`**: Creates an execution plan (preview of changes).
3. **`terraform apply`**: Applies changes to create/modify resources.
4. **`terraform destroy`**: Destroys all resources managed by Terraform.
5. **`terraform state list`**: Lists all resources in the state file.

---

## **7. Writing Terraform Configuration**

### **Example: `main.tf`**
```hcl
provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "example" {
  ami           = "ami-0f5ee92e2d63afc18"  # Amazon Linux 2 AMI
  instance_type = "t2.micro"
}
```

### **Explanation:**
- **Provider Block**: Specifies the cloud provider (AWS) and region.
- **Resource Block**: Defines the resource to create (e.g., EC2 instance).
- **Arguments**: `ami` and `instance_type` are required for EC2 instances.

### **Commands to Execute:**
```bash
terraform init    # Initialize providers
terraform plan    # Preview changes
terraform apply   # Create resources
```

---

## **8. Variables in Terraform**

### **Why Use Variables?**
- Avoid hardcoding values.
- Make code reusable and dynamic.

### **Example: `variables.tf`**
```hcl
variable "instance_type" {
  description = "Type of EC2 instance"
  type        = string
  default     = "t2.micro"
}

variable "instance_count" {
  description = "Number of instances"
  type        = number
  default     = 5
}
```

### **Using Variables in `main.tf`:**
```hcl
resource "aws_instance" "example" {
  count         = var.instance_count
  ami           = "ami-0f5ee92e2d63afc18"
  instance_type = var.instance_type
}
```

---

## **9. State Management**

- **State File**: `terraform.tfstate` tracks all resources created by Terraform.
- **Purpose**: 
  - Maps real-world resources to your configuration.
  - Tracks metadata (e.g., IP addresses, IDs).
- **Remote State**: Store state file in remote storage (e.g., S3) for teamwork.

### **Commands:**
- `terraform state list`: List all tracked resources.
- `terraform state show <resource>`: Show details of a resource.

---

## **10. Targeting Specific Resources**

### **Destroy a Specific Resource:**
```bash
terraform destroy -target=aws_instance.example[0]
```

### **Apply Changes to a Specific Resource:**
```bash
terraform apply -target=aws_instance.example[0]
```

### **Skip Prompt for Approval:**
```bash
terraform apply -auto-approve
terraform destroy -auto-approve
```

---

## **11. Best Practices**

1. **Use Variables**: Avoid hardcoding values.
2. **Modularize Code**: Break code into reusable modules.
3. **Remote State**: Store state files in S3 or similar.
4. **Version Control**: Use Git to track changes.
5. **Documentation**: Add comments and descriptions.

---

## **12. Summary**

- **Terraform** automates infrastructure creation.
- **HCL** is used to write configuration files.
- **Commands**: `init`, `plan`, `apply`, `destroy`.
- **Variables** make code dynamic.
- **State files** track resource status.
- **Targeting** allows managing specific resources.

---

## **Next Steps**
- Learn about **modules** for reusability.
- Explore **remote state storage** (e.g., S3 + DynamoDB).
- Practice creating complex infrastructure (VPC, ASG, ELB).

---
