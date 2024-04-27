data "aws_iam_policy_document" "ecs_task_assume_policy" { 
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs-task.amazonaws.com"]
    }
  }
}

# Create a data source to pull the latest active revision from
data "aws_ecs_task_definition" "default" {
  task_definition = aws_ecs_task_definition.default.family
  depends_on      = [aws_ecs_task_definition.default] # ensures at least one task def exists
}
