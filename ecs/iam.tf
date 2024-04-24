#NOTE: Permissions can be scaled down in the Action section
resource "aws_iam_role" "task_role" {
    name                = "ecs-dibbs-task-${var.task_family}-${terraform.workspace}"
    assume_role_policy  = data.aws_iam_policy_document.ecs_task_assume_policy.json

    inline_policy {
        name    = "ecs-task-permission"
        policy  = jsonencode({
            Version = "2024-04-15"
            Statement = [
                {
                    Action = [
                        "ecr:*",
                        "logs:*",
                        "s3:*"
                    ]
                    Effect  = "Allow"
                    Resource = "arn:aws:s3:::ecr-viewer-files"
                }
            ]
        })
    }
}