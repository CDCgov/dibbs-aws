# task execution role
resource "aws_iam_role" "ecs_task_execution" {
  name               = var.ecs_task_execution_role_name
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}
# task execution role
resource "aws_iam_policy" "ecs_task_execution" {
  name        = "${var.ecs_task_execution_role_name}-policy"
  policy      = data.aws_iam_policy_document.ecs_task_execution.json
}
# task execution role
resource "aws_iam_role_policy_attachment" "ecs_task_execution" {
  role       = aws_iam_role.ecs_task_execution.name
  policy_arn = aws_iam_policy.ecs_task_execution.arn
}

# empty task role
resource "aws_iam_role" "ecs_task" {
  name               = var.ecs_task_role_name
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

# s3
resource "aws_iam_role" "s3_role_for_ecr_viewer" {
  name               = var.s3_viewer_bucket_role_name
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}
# s3
resource "aws_iam_policy" "s3_bucket_ecr_viewer" {
  name        = "${var.s3_viewer_bucket_role_name}-policy"
  description = "Policy for ECR-Viewer and S3 for DIBBS-AWS"
  policy      = data.aws_iam_policy_document.ecr_viewer_s3.json
}
# s3
resource "aws_iam_role_policy_attachment" "s3_bucket_ecr_viewer" {
  role       = aws_iam_role.s3_role_for_ecr_viewer.name
  policy_arn = aws_iam_policy.s3_bucket_ecr_viewer.arn
}
