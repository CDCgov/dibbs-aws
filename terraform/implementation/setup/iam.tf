data "aws_caller_identity" "current" {}

# # create a role that can be assumed to pull and push docker images from 
data "aws_iam_policy_document" "github_assume_role" {
  statement {
    principals {
      type        = "Federated"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:oidc-provider/token.actions.githubusercontent.com"]
    }
    actions = [
      "sts:AssumeRoleWithWebIdentity"
    ]
    condition {
      test     = "StringEquals"
      variable = "token.actions.githubusercontent.com:aud"
      values   = ["sts.amazonaws.com", ]
    }
    condition {
      test     = "StringLike"
      variable = "token.actions.githubusercontent.com:sub"
      values = [
        "repo:${var.oidc_github_repo}:*",
      ]
    }
  }
}

# TODO: https://github.com/CDCgov/dibbs-aws/issues/8
# trivy:ignore:AVD-AWS-0057
data "aws_iam_policy_document" "github" {
  statement {
    actions = [
      "appmesh:*",
      "dynamodb:*",
      "ec2:*",
      "ecr:*",
      "ecs:*",
      "elasticloadbalancing:*",
      "iam:*",
      "logs:*",
      "s3:*",
      "servicediscovery:*",
      "ecs:UpdateService",
    ]
    resources = [
      "*"
    ]
  }
}

resource "aws_iam_policy" "github" {
  name   = "${var.project}-github-policy-${var.owner}-${random_string.setup.result}"
  policy = data.aws_iam_policy_document.github.json
}

resource "aws_iam_role" "github" {
  name               = "${var.project}-github-role-${var.owner}-${random_string.setup.result}"
  assume_role_policy = data.aws_iam_policy_document.github_assume_role.json
}

resource "aws_iam_role_policy_attachment" "github" {
  role       = aws_iam_role.github.name
  policy_arn = aws_iam_policy.github.arn
}
