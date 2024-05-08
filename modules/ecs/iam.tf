resource "aws_iam_role" "ecs_task_execution_role" {
  name = "${var.ecs_task_execution_role_name}-${var.env}"
  assume_role_policy = data.aws_iam_policy_document.ecs_task_assume_role_policy.json
}

##############################################
##### IAM PERMISSIONS FOR ECS & ECS AUTH #####
##############################################

resource "aws_iam_role_policy_attachment" "ecs-task-execution-role-policy-attachment" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_iam_policy" "ecr_policy" {
  name        = "ecr-policy"
  description = "Policy for ECS tasks to access ECR"
  policy      = data.aws_iam_policy_document.ecr_and_ecs_permissions_policy_document.json
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution_role_attachment" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = aws_iam_policy.ecr_policy.arn
}