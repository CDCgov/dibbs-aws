resource "aws_ecs_task_definition" "dibbs_task" {
  family                   = "${var.env}-${var.task_name}"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  memory                   = var.launch_type.memory
  cpu                      = var.launch_type.cpu
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  task_role_arn            = aws_iam_role.task_role.arn

  container_definitions = jsonencode([{
    name      = "${var.env}-patient-impact"
    #image     = "${data.aws_ecr_repository.default.repository_url}:${var.ecr_image_tag}"
    image     = "${data.aws_ecr_repository.default.repository_url}"
    cpu       = var.launch_type.cpu
    memory    = var.launch_type.memory
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
        "awslogs-group"         = aws_cloudwatch_log_group.patient_impact.name,
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

resource "aws_cloudwatch_log_group" "patient_impact" {
  name = "${var.env}-patient-impact-api"
}