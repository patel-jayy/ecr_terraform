# Generate a random suffix for secret name to avoid duplicates
resource "random_string" "secret_suffix" {
  length  = 6
  upper   = false
  special = false
}

# Generate random DB password
resource "random_password" "db_password" {
  length  = 16
  special = true
}

# Security group for RDS
resource "aws_security_group" "rds_sg" {
  name        = "rds-sg"
  description = "Allow ECS to access RDS"
  vpc_id      = var.vpc_id

  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [var.ecs_sg_id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# RDS MySQL instance
resource "aws_db_instance" "app_db" {
  identifier        = "ecs-app-db"
  engine            = "mysql"
  engine_version    = "8.0"
  instance_class    = "db.t3.micro"
  allocated_storage = 20
  storage_type      = "gp2"
  username          = "dbuser"
  password          = random_password.db_password.result
  db_name           = "mydb"

  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  multi_az               = false
  publicly_accessible    = false
  skip_final_snapshot    = true
  deletion_protection    = false
  apply_immediately      = true
  db_subnet_group_name   = aws_db_subnet_group.rds_subnets.name
}

# Subnet group for RDS
resource "aws_db_subnet_group" "rds_subnets" {
  name       = "rds-subnet-group"
  subnet_ids = var.private_subnets
  tags = {
    Name = "rds-subnets"
  }
}

# Store DB credentials in Secrets Manager
resource "aws_secretsmanager_secret" "db_secret" {
  name        = "mysql-db-credentials-${random_string.secret_suffix.result}"
  description = "RDS credentials for ECS app"
}

resource "aws_secretsmanager_secret_version" "db_secret_value" {
  secret_id     = aws_secretsmanager_secret.db_secret.id
  secret_string = jsonencode({
    username = aws_db_instance.app_db.username
    password = aws_db_instance.app_db.password
    host     = aws_db_instance.app_db.address
    dbname   = aws_db_instance.app_db.db_name
  })
}
