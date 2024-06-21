resource "aws_iam_role" "ecs_task_execution_role" {
  name               = var.ecs_task_execution_role_name
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution_role_policy_attachment" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_iam_policy" "ecr_policy" {
  name        = var.ecs_ecr_policy_name
  description = "Policy for ECS tasks to access ECR"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "ecr:GetAuthorizationToken",
          "ecr:BatchCheckLayerAvailability",
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage"
        ]
        Resource = [
          "arn:aws:ecs:${var.region}:${var.aws_caller_identity}:cluster/${var.ecs_cluster_name}/*",
          "arn:aws:ecs:${var.region}:${var.aws_caller_identity}:cluster/${var.ecs_cluster_name}",
          "arn:aws:ecs:${var.region}:${var.aws_caller_identity}:service/${var.ecs_cluster_name}/ecr-viewer/*",
          "arn:aws:ecs:${var.region}:${var.aws_caller_identity}:service/${var.ecs_cluster_name}/ecr-viewer",
          "arn:aws:ecs:${var.region}:${var.aws_caller_identity}:service/${var.ecs_cluster_name}/orchestration/*",
          "arn:aws:ecs:${var.region}:${var.aws_caller_identity}:service/${var.ecs_cluster_name}/orchestration",
          "arn:aws:ecs:${var.region}:${var.aws_caller_identity}:service/${var.ecs_cluster_name}/fhir-converter/*",
          "arn:aws:ecs:${var.region}:${var.aws_caller_identity}:service/${var.ecs_cluster_name}/fhir-converter",
          "arn:aws:ecs:${var.region}:${var.aws_caller_identity}:service/${var.ecs_cluster_name}/ingestion/*",
          "arn:aws:ecs:${var.region}:${var.aws_caller_identity}:service/${var.ecs_cluster_name}/ingestion",
          "arn:aws:ecs:${var.region}:${var.aws_caller_identity}:service/${var.ecs_cluster_name}/validation/*",
          "arn:aws:ecs:${var.region}:${var.aws_caller_identity}:service/${var.ecs_cluster_name}/validation",
        ]
      }
    ],
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream"
        ]
        Resource = [
          "*"
        ]
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution_role_policy_secondary_attachment" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = aws_iam_policy.ecr_policy.arn
}

data "aws_iam_policy_document" "ecs_task_definition_execution_policy" {
  statement {
    actions = [
      "ec2:DescribeNetworkInterfaces",
      "ec2:CreateNetworkInterface",
      "ec2:DeleteNetworkInterface",
      "ec2:DescribeInstances",
      "ec2:AttachNetworkInterface",
      "servicediscovery:DiscoverInstances"
    ]
    resources = [
      "arn:aws:eks:${var.region}:${var.aws_caller_identity}:cluster/phdi-playground-dev",
      "arn:aws:eks:${var.region}:${var.aws_caller_identity}:cluster/phdi-playground-dev/*",
      "arn:aws:ecs:${var.region}:${var.aws_caller_identity}:cluster/${var.ecs_cluster_name}/*",
      "arn:aws:ecs:${var.region}:${var.aws_caller_identity}:cluster/${var.ecs_cluster_name}",
    ]
  }
}

data "aws_iam_policy_document" "ecs_cloudwatch_policy" {
  statement {
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]
    resources = [
      "arn:aws:logs:${var.region}:${var.aws_caller_identity}:log-group:/ecs/ecrviewer:*",
      "arn:aws:logs:${var.region}:${var.aws_caller_identity}:log-group:/ecs/ingestion:*",
      "arn:aws:logs:${var.region}:${var.aws_caller_identity}:log-group:/ecs/fhir-converter:*",
      "arn:aws:logs:${var.region}:${var.aws_caller_identity}:log-group:/ecs/validation:*",
      "arn:aws:logs:${var.region}:${var.aws_caller_identity}:log-group:/ecs/orchestration:*"
    ]
  }
}

resource "aws_iam_policy" "ecs_cloudwatch_policy" {
  name        = var.ecs_cloudwatch_policy_name
  description = "IAM policy for ECS task to create CloudWatch Logs group"
  policy      = data.aws_iam_policy_document.ecs_cloudwatch_policy.json
}

resource "aws_iam_role" "ecs_cloudwatch_role" {
  name               = var.ecs_cloudwatch_role_name
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
}

resource "aws_iam_role_policy_attachment" "ecs_cloudwatch_attachment" {
  role       = aws_iam_role.ecs_cloudwatch_role.name
  policy_arn = aws_iam_policy.ecs_cloudwatch_policy.arn
}
