# ECS + RDS Terraform Deployment

This Terraform project deploys a **Node.js application** on **AWS ECS (EC2 launch type)** with a **MySQL RDS backend**, secured with **AWS Secrets Manager**. The application is exposed via an **Application Load Balancer (ALB)** in a custom VPC.

---

## Architecture

- **VPC**: Custom VPC with public and private subnets.
- **ECS Cluster**: EC2 launch type, running Node.js application containers.
- **ALB**: Public-facing load balancer routing traffic to ECS tasks.
- **RDS**: MySQL instance in private subnets.
- **Secrets Manager**: Stores DB credentials securely.
- **CloudWatch**: Logs and metrics for ECS and infrastructure.

```
      Internet
          |
          |
       [ALB - Public Subnets]
          |
          |---> [ECS Cluster - Private Subnets]
                     |
                     |---> [RDS MySQL - Private Subnets]
```

---

## Requirements

- Terraform >= 1.5
- AWS CLI configured with access to your account
- AWS Account with ECS, RDS, VPC, and Secrets Manager permissions

---

## Directory Structure

```
.
├── main.tf
├── output.tf
├── variables.tf
├── modules/
│   ├── vpc/
│   │   └── vpc.tf
│   ├── ecs/
│   │   ├── ecs.tf
│   │   ├── variables.tf
│   │   └── output.tf
│   └── rds/
│       ├── rds.tf
│       ├── variables.tf
│       └── output.tf
```

---

## Usage

1. Initialize Terraform:
```bash
terraform init
```

2. Validate configuration:
```bash
terraform validate
```

3. Plan deployment:
```bash
terraform plan
```

4. Apply deployment:
```bash
terraform apply
```

5. Destroy infrastructure:
```bash
terraform destroy
```

---

## Outputs

After applying, Terraform provides:

- `vpc_id` → VPC ID
- `public_subnets` → List of public subnet IDs
- `private_subnets` → List of private subnet IDs
- `ecs_cluster_id` → ECS cluster ARN
- `ecs_service_name` → ECS service name
- `rds_endpoint` → MySQL hostname
- `db_secret_arn` → Secrets Manager ARN

---

## Secrets Management

- Database credentials are **randomly generated**.
- Stored in **AWS Secrets Manager**.
- ECS tasks retrieve secrets using an **IAM task role** with `SecretsManagerReadWrite` permissions.
- Credentials include:
  - `username`
  - `password`
  - `host` (RDS endpoint)
  - `dbname` (database name)

---

## Logging and Monitoring

- **ECS Logs** → CloudWatch Logs for each container.
- **Application Logs** → CloudWatch Logs.
- **Metrics and Alarms**:
  - CPU / Memory Utilization of ECS instances.
  - ECS Task Failures.
  - CloudWatch alarms can be configured to notify via SNS.

---

## Notes

- VPC CIDR: `172.16.0.0/16`
- Public subnets for ALB, private subnets for ECS and RDS.
- Ensure AWS account limits allow for EC2 instances, RDS, and security groups.
