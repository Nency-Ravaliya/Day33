# Terraform AWS Multi-Tier Architecture Deployment

This guide provides a step-by-step approach to deploying a multi-tier architecture on AWS using Terraform. The deployment includes a VPC, EC2 instances, an RDS MySQL database, an S3 bucket, and security groups, utilizing AWS Free Tier resources.

## Table of Contents
- [Prerequisites](#prerequisites)
- [Setup Instructions](#setup-instructions)
  - [Step 1: Configure Terraform Backend](#step-1-configure-terraform-backend)
  - [Step 2: Initialize Terraform](#step-2-initialize-terraform)
  - [Step 3: Create Terraform Modules](#step-3-create-terraform-modules)
  - [Step 4: Define Variables and tfvars](#step-4-define-variables-and-tfvars)
  - [Step 5: Create Workspaces](#step-5-create-workspaces)
  - [Step 6: Deploy Infrastructure](#step-6-deploy-infrastructure)
- [Project Structure](#project-structure)
- [Lifecycle Rules](#lifecycle-rules)
- [Conclusion](#conclusion)

## Prerequisites
- AWS account
- Terraform installed on your local machine
- AWS CLI configured with your credentials
- AWS IAM permissions to create resources

## Setup Instructions

### Step 1: Configure Terraform Backend

**Create an S3 Bucket for Terraform State:**

1. Log in to the AWS Management Console.
2. Navigate to S3 and create a bucket named `your-bucket-name` in your desired region.

**Create a DynamoDB Table for State Locking:**

1. Navigate to DynamoDB in the AWS Management Console.
2. Create a table named `terraform-lock-table` with a primary key `LockID` (String).

**Configure the Backend:**

Update the `main.tf` file in your repository with your backend configuration:

```
terraform {
  backend "s3" {
    bucket         = "your-bucket-name"
    key            = "terraform/state.tfstate"
    region         = "your-region"
    dynamodb_table = "terraform-lock-table"
    encrypt        = true
  }
}
```

### Step 2: Initialize Terraform
Run the following command to initialize Terraform and download necessary plugins:
`terraform init`

### Step 3: Create Terraform Modules
The repository contains various modules to manage different parts of the infrastructure. Ensure you have the following modules in your repository:

EC2 Module: Located at modules/ec2/
IAM Module: Located at modules/iam/
RDS Module: Located at modules/rds/
S3 Module: Located at modules/s3/
Security Group Module: Located at modules/security_group/
VPC Module: Located at modules/vpc/
Refer to these directories for the module implementations and ensure they are correctly defined as per your project requirements.

### Step 4: Define Variables and tfvars
Define Global Variables:

Update the variables.tf file with global variables for your configuration:
```
variable "aws_profile" {}
variable "vpc_cidr" {}
variable "public_subnet_cidrs" {}
variable "private_subnet_cidrs" {}
variable "availability_zones" {}
variable "ami_id" {}
variable "instance_type" {}
variable "db_username" {}
variable "db_password" {}
```
Create Environment-Specific tfvars Files:

Define values in dev.tfvars and prod.tfvars:

# dev.tfvars
```
aws_profile = "default"
vpc_cidr = "10.0.0.0/16"
```

### Step 5: Create Workspaces
Initialize Workspaces:
Create and select workspaces for different environments:
```
terraform workspace new dev
terraform workspace new prod
```

### Step 6: Deploy Infrastructure

Select Workspace:
Choose the appropriate workspace:
```
terraform workspace select dev
```
Apply Configuration:

Apply the configuration using the appropriate .tfvars file:
```
terraform apply -var-file="dev.tfvars"
#terraform destroy -var="aws_profile=dev"
```

# Output

![image](https://github.com/user-attachments/assets/32054665-7163-4c39-9217-2d37426fd85b)
![image](https://github.com/user-attachments/assets/ccaab7ad-503f-49dd-b0e6-a44661b28563)
![image](https://github.com/user-attachments/assets/4cebd364-192d-4a0c-b9ba-70f3282b534b)
![image](https://github.com/user-attachments/assets/3bb01002-72b9-4377-ae1d-b926eb70846e)
![image](https://github.com/user-attachments/assets/a80ec293-e63a-4cd1-83f2-50f06e7b4393)
![image](https://github.com/user-attachments/assets/72126cac-56d1-4ea4-a37e-fa424effa483)
![image](https://github.com/user-attachments/assets/c0b2ae00-c874-4c5b-8add-28602060cb82)
![image](https://github.com/user-attachments/assets/49db3dba-41e1-4e60-8e88-363ae10e9324)
![image](https://github.com/user-attachments/assets/e319a562-614d-4b99-9129-d672f07f638d)
![image](https://github.com/user-attachments/assets/5341ed82-6839-4472-bff1-520e634d6002)
![image](https://github.com/user-attachments/assets/8e208a3b-6e9d-4cdd-9e11-19dc15e84f85)
![image](https://github.com/user-attachments/assets/42dc1555-50bf-42bc-9d77-ad5548520233)
![image](https://github.com/user-attachments/assets/f64c6823-5f1d-4cc1-aebd-f20ee0595e3e)
![image](https://github.com/user-attachments/assets/79f34d7d-c4e3-41ae-aee3-d34edc13a3fe)
![image](https://github.com/user-attachments/assets/8a895d74-acb8-4d5c-a9c9-ee0e0a238408)
![image](https://github.com/user-attachments/assets/b635013c-6d77-4b21-a179-d40112bc55c0)














