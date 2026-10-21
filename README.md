# AWS Cloud DevSecOps Platform

A hands-on cloud infrastructure project built with Terraform and AWS.

## Project Overview

This project demonstrates how to provision and manage AWS infrastructure using Infrastructure as Code (IaC).

The current infrastructure includes:
- A custom VPC
- A public subnet
- An Internet Gateway
- A public route table
- A Security Group allowing HTTP traffic
- An optional EC2 instance running Nginx

The infrastructure is deployed in the AWS Frankfurt region (eu-central-1).


## Architecture

The infrastructure follows a simple AWS networking architecture:

```text
Internet
   |
Internet Gateway
   |
Public Route Table
   |
Public Subnet (10.20.1.0/24)
   |
EC2 Instance (Optional)
   |
Nginx Web Server
```

### Network Configuration

- **AWS Region:** eu-central-1 (Frankfurt)
- **VPC CIDR:** 10.20.0.0/16
- **Public Subnet CIDR:** 10.20.1.0/24
- **Availability Zone:** eu-central-1a
- **Inbound Traffic:** HTTP (TCP port 80)
- **Outbound Traffic:** Allowed

### EC2 Configuration

- **Instance Type:** t3.micro
- **Operating System:** Amazon Linux 2023
- **Web Server:** Nginx
- **Provisioning:** Terraform user_data script
- **Deployment:** Controlled by the create_ec2 variable
