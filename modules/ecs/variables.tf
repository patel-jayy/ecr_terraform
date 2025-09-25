variable "vpc_id" {
  description = "VPC ID where ECS resources will be deployed"
  type        = string
}

variable "private_subnets" {
  description = "Private subnets for ECS tasks"
  type        = list(string)
}

variable "public_subnets" {
  description = "Public subnets for ALB"
  type        = list(string)
}
