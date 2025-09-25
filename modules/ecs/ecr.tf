resource "aws_ecr_repository" "app_repo" {
  name                 = "ecs-node-app-repo"
  image_tag_mutability = "MUTABLE"

  tags = {
    Environment = "prod"
  }
}

data "aws_ecr_authorization_token" "auth" {}

output "ecr_repo_url" {
  value = aws_ecr_repository.app_repo.repository_url
}

output "ecr_auth" {
  value = {
    username = data.aws_ecr_authorization_token.auth.user_name
    password = data.aws_ecr_authorization_token.auth.password
  }
}
