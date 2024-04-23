data "aws_iam_policy_document" "ecs_task_assume_policy" { 
    statement {
        actions = ["sts:AssumeRole"]
        principals {
            type        = "Service"
            identifiers = ["ecs-task.amazonaws.com"]
        }
    }
}