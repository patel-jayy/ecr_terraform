output "vpc_id" {
  value = module.vpc_setup.vpc_id
}

output "public_subnets" {
  value = module.vpc_setup.public_subnets
}

output "private_subnets" {
  value = module.vpc_setup.private_subnets
}

output "ecs_cluster_id" {
  value = module.ecs_setup.ecs_cluster_id
}

output "ecs_service_name" {
  value = module.ecs_setup.ecs_service_name
}

output "rds_endpoint" {
  value = module.rds_setup.rds_endpoint
}

output "db_secret_arn" {
  value = module.rds_setup.db_secret_arn
}
