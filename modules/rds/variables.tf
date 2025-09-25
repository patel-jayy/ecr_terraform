variable "vpc_id" {
  description = "VPC ID where RDS will be deployed"
  type        = string
}

variable "private_subnets" {
  description = "Private subnets for RDS"
  type        = list(string)
}

variable "ecs_sg_id" {
  description = "Security group ID of ECS instances allowed to access RDS"
  type        = string
}
