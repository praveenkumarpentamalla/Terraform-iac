## **Table of Contents**
1. [Recap of Terraform Basics](#1-recap-of-terraform-basics)
2. [Variables in Terraform](#2-variables-in-terraform)
3. [Variable Files (`variables.tf`)](#3-variable-files-variablestf)
4. [Variable Value Files (`.tfvars`)](#4-variable-value-files-tfvars)
5. [Passing Variables via CLI](#5-passing-variables-via-cli)
6. [Outputs in Terraform](#6-outputs-in-terraform)
7. [Terraform Import](#7-terraform-import)
8. [Best Practices](#8-best-practices)
9. [Summary](#9-summary)

---

## **1. Recap of Terraform Basics**

- **Terraform**: Infrastructure as Code (IaC) tool for automating cloud infrastructure.
- **Advantages**: Saves time, reduces errors, reusable, cloud-agnostic.
- **Basic Commands**:
  - `terraform init`: Initializes providers.
  - `terraform plan`: Previews changes.
  - `terraform apply`: Applies changes.
  - `terraform destroy`: Destroys resources.

---

## **2. Variables in Terraform**

Variables make Terraform code dynamic and reusable. They can be defined in multiple ways:

### **Example: Variable Block**
```hcl
variable "instance_count" {
  description = "Number of EC2 instances"
  type        = number
  default     = 1
}

variable "instance_type" {
  description = "Type of EC2 instance"
  type        = string
  default     = "t2.micro"
}
```

### **Using Variables in `main.tf`:**
```hcl
resource "aws_instance" "example" {
  count         = var.instance_count
  ami           = "ami-0f5ee92e2d63afc18"
  instance_type = var.instance_type
  tags = {
    Name = "raham-server"
  }
}
```

---

## **3. Variable Files (`variables.tf`)**

Store variable definitions in a separate file for better organization.

### **Why Use `variables.tf`?**
- Avoid cluttering `main.tf`.
- Easier to manage and modify variables.
- Improves readability.

### **Example: `variables.tf`**
```hcl
variable "instance_count" {
  type    = number
  default = 1
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}
```

---

## **4. Variable Value Files (`.tfvars`)**

Use `.tfvars` files to store variable values for different environments (e.g., dev, test, prod).

### **Example: `dev.tfvars`**
```hcl
instance_count = 1
instance_type  = "t2.micro"
```

### **Example: `test.tfvars`**
```hcl
instance_count = 2
instance_type  = "t2.medium"
```

### **Applying with `.tfvars` Files:**
```bash
# For development environment
terraform apply -auto-approve -var-file="dev.tfvars"

# For testing environment
terraform apply -auto-approve -var-file="test.tfvars"
```

### **Benefits:**
- No need to edit `main.tf` or `variables.tf` for different environments.
- Reuse the same code with different configurations.

---

## **5. Passing Variables via CLI**

Variables can be passed directly via the command line.

### **Example:**
```bash
terraform apply -auto-approve -var="instance_count=3" -var="instance_type=t2.large"
```

### **Note**: CLI values override values from `.tfvars` files and defaults.

---

## **6. Outputs in Terraform**

Outputs display information about created resources (e.g., IP addresses, IDs).

### **Example: Output Block**
```hcl
output "public_ip" {
  description = "Public IP of the EC2 instance"
  value       = aws_instance.example[0].public_ip
}

output "private_ip" {
  description = "Private IP of the EC2 instance"
  value       = aws_instance.example[0].private_ip
}

output "public_dns" {
  description = "Public DNS of the EC2 instance"
  value       = aws_instance.example[0].public_dns
}
```

### **Viewing Outputs:**
```bash
terraform output
```

### **Benefits:**
- Quickly access resource details without checking the AWS console.
- Useful for automation and scripting.

---

## **7. Terraform Import**

Import existing manually created resources into Terraform state.

### **Why Use Import?**
- Track manually created resources using Terraform.
- Manage all resources consistently.

### **Steps to Import:**
1. Define the resource in `main.tf`:
   ```hcl
   resource "aws_instance" "example" {
     # Configuration must match the existing resource
     instance_type = "t2.micro"
     ami           = "ami-0f5ee92e2d63afc18"
   }
   ```
2. Run the import command:
   ```bash
   terraform import aws_instance.example <instance-id>
   ```
3. Verify the state:
   ```bash
   terraform state list
   ```

### **Example:**
```bash
terraform import aws_instance.example i-1234567890abcdef0
```

---

## **8. Best Practices**

1. **Use Variables**: Avoid hardcoding values.
2. **Separate Files**: Use `variables.tf` for definitions and `.tfvars` for values.
3. **Outputs**: Define outputs for critical resource attributes.
4. **State Management**: Store state files remotely (e.g., S3) for teamwork.
5. **Modularize**: Break code into reusable modules.

---

## **9. Summary**

- **Variables**: Make code dynamic and reusable.
- **Variable Files**: Use `variables.tf` for definitions and `.tfvars` for environment-specific values.
- **CLI Variables**: Pass values directly via command line.
- **Outputs**: Display resource details after creation.
- **Import**: Bring existing resources under Terraform management.

---

## **Next Steps**
- Practice creating multi-environment setups using `.tfvars`.
- Explore remote state storage (e.g., S3 + DynamoDB).
- Learn about Terraform modules for reusability.

---
