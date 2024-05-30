# resource "aws_iam_role" "ecs_task_execution_role" {
#   name               = "${var.ecs_task_execution_role_name}-${var.env}"
#   assume_role_policy = data.aws_iam_policy_document.ecs_task_assume_role_policy.json
# }

##############################################
##### IAM PERMISSIONS FOR ECS & ECS AUTH #####
##############################################

resource "aws_iam_role_policy_attachment" "ecs-task-execution-role-policy-attachment" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_iam_policy" "ecr_policy" {
  name        = "ecr-access-policy"
  description = "Policy for ECS tasks to access ECR"
  # policy      = data.aws_iam_policy_document.ecr_and_ecs_permissions_policy_document.json
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage",
          "ecr:BatchCheckLayerAvailability"
        ]
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution_role_attachment" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = aws_iam_policy.ecr_policy.arn
}

###################################################
##### IAM PERMISSIONS FOR ECS TASK DEFINITION #####
###################################################

# Define the IAM policy document for ECS task execution role
data "aws_iam_policy_document" "ecs_task_definition_execution_policy" {
  statement {
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchGetImage",
      "ecr:BatchCheckLayerAvailability",
      "ec2:DescribeNetworkInterfaces",
      "ec2:CreateNetworkInterface",
      "ec2:DeleteNetworkInterface",
      "ec2:DescribeInstances",
      "ec2:AttachNetworkInterface",
    ]
    resources = [
      "arn:aws:eks:us-east-1:339712971032:cluster/phdi-playground-dev",
      "arn:aws:eks:us-east-1:339712971032:cluster/phdi-playground-dev/*",
      "*"
    ]
  }
}

# Create IAM policy for ECS task execution role
# resource "aws_iam_policy" "ecs_task_definition_execution_policy" {
#   name   = "ecs-task-definition-execution-policy"
#   policy = data.aws_iam_policy_document.ecs_task_definition_execution_policy.json
# }

# Create IAM role for ECS task execution
resource "aws_iam_role" "ecs_task_definition_execution_role" {
  name = "ecs-task-execution-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = {
        Service = "ecs-tasks.amazonaws.com"
      },
      Action = "sts:AssumeRole"
    }]
  })
}

# resource "aws_iam_role_policy_attachment" "ecs_task_definition_execution_policy_attachment" {
#   role       = aws_iam_role.ecs_task_definition_execution_role.name
#   policy_arn = aws_iam_policy.ecs_task_definition_execution_policy.arn
# }
