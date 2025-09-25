output "ecs_cluster_id" {
  value = aws_ecs_cluster.app_cluster.id
}

output "ecs_service_name" {
  value = aws_ecs_service.app_service.name
}

output "ecs_sg_id" {
  value = aws_security_group.ecs_sg.id
}
