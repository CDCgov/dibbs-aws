resource "aws_ecs_cluster" "ecs_cluster" {
 name = "dibbs-ecs-cluster"
}

resource "aws_ecr_repository" "repo" {
  name = "dibbs-ecr-repository"
  
  # Optionally, you can add more configurations like image scanning
  image_scanning_configuration {
    scan_on_push = true
  }
}


resource "aws_cloudwatch_log_group" "log_group" {
  name              = "dibbs-ecs-log-group"
  retention_in_days = var.retention_in_days
  tags              = var.tags
}