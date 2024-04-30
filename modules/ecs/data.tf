data "aws_iam_policy_document" "ecs_task_assume_role_policy" { 
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

# Create a data source to pull the latest active revision from
data "aws_ecs_task_definition" "default_app_task" {
  task_definition = aws_ecs_task_definition.default_app_task.family
  depends_on      = [aws_ecs_task_definition.default_app_task] # ensures at least one task def exists
}
