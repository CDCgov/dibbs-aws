/*resource "aws_ecs_task_definition" "default_app_task" {
  family                   = "${var.app_task_family}-${var.env}"
  network_mode             = "awsvpc"
  #requires_compatibilities = [var.launch_type.type]
  requires_compatibilities = ["FARGATE"]
  memory                   = var.launch_type.memory
  cpu                      = var.launch_type.cpu
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  task_role_arn            = aws_iam_role.task_role.arn

  container_definitions = jsonencode([{
    name      = "${var.app_task_name}-${var.env}"
    # TODO: Update this with the variable from ecr
    image     = var.aws_ecr_repository 
    cpu       = var.launch_type.cpu
    memory    = var.launch_type.memory
    essential = true
    portMappings = [
      {
        containerPort = var.container_port
      }
    ]
    logConfiguration = {
      logDriver = "awslogs",
      options = {
        "awslogs-region"        = var.region,
        #"awslogs-group"         = "{{ aws_cloudwatch_log_group.ecs_logs.name }}",
        "awslogs-stream-prefix" = "disaster-tracking",
      }
    }
  }])
}*/

resource "aws_ecs_task_definition" "default_app_task" {
  family                   = "${var.app_task_family}-${var.env}"
  container_definitions    = <<DEFINITION
  [
    {
      "name": "${var.app_task_name}",
      "image": "${var.ecr_repo_url}",
      "essential": true,
      "portMappings": [
        {
          "containerPort": ${var.container_port},
          "hostPort": ${var.container_port}
        }
      ],
      "memory": ${var.launch_type.memory},
      "cpu": ${var.launch_type.cpu}
    }
  ]
  DEFINITION
  
  network_mode              = "awsvpc"
  #requires_compatibilities = [var.launch_type.type]
  requires_compatibilities  = ["FARGATE"]
  memory                    = var.launch_type.memory
  cpu                       = var.launch_type.cpu
  execution_role_arn        = aws_iam_role.ecs_task_execution_role.arn
  #task_role_arn            = aws_iam_role.task_role.arn
}