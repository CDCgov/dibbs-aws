#NOTE: Permissions can be scaled down in the Action section
resource "aws_iam_role" "task_role" {
    name                = "ecs-dibbs-task-${terraform.workspace}"
    #assume_role_policy  = data.aws_iam_policy_document.ecs_task_assume_policy.json

    assume_role_policy = <<EOF
    {
        "Version": "2012-10-17",
        "Statement": [
        {
            "Action": "sts:AssumeRole",
            "Principal": {
                "Service": "ecs.amazonaws.com"
            },
            "Effect": "Allow",
            "Sid": ""
        }]
    }
    EOF
}

resource "aws_iam_role" "ecs_task_execution_role" {
  name = "${var.ecs_task_execution_role_name}-${var.env}"
  assume_role_policy = data.aws_iam_policy_document.ecs_task_assume_policy.json
}

resource "aws_iam_role_policy_attachment" "ecs-task-execution-role-policy-attachment" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}