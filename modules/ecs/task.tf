resource "aws_ecs_task_definition" "dibbs_task" {
  family                   = "${var.env}-${var.task_name}"
  network_mode             = "awsvpc"
  requires_compatibilities = [var.launch_type.default.type]
  memory                   = var.launch_type.default.memory
  cpu                      = var.launch_type.default.cpu
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  task_role_arn            = aws_iam_role.task_role.arn

  container_definitions = jsonencode([{
    name      = "${var.task_name}-${var.env}"
    #image     = "${var.ecr_repo_name}"
    cpu       = var.launch_type.default.cpu
    memory    = var.launch_type.default.memory
    essential = true
    portMappings = [
      {
        containerPort = 8080
      }
    ]
    logConfiguration = {
      logDriver = "awslogs",
      options = {
        "awslogs-region"        = var.region,
        "awslogs-group"         = aws_cloudwatch_log_group.ecs_logs.name,
        "awslogs-stream-prefix" = "disaster-tracking",
      }
    }
    environment = [
      {
        name  = "SPRING_DATASOURCE_URL",
        value = "jdbc:postgresql://${var.db_endpoint}/${var.db_name}"
      },
      {
        name  = "SPRING_PROFILES_ACTIVE",
        value = "prod"
      }
    ]
    secrets = []
  }])
}
