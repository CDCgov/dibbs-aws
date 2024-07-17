data "aws_caller_identity" "current" {}

data "aws_iam_policy" "amazon_vpc_full_access" {
  name = "AmazonVPCFullAccess"
}

data "aws_iam_policy" "amazon_ec2_full_access" {
  name = "AmazonEC2FullAccess"
}

data "aws_iam_policy" "aws_appmesh_full_access" {
  name = "AWSAppMeshFullAccess"
}

data "aws_iam_policy" "amazon_dynamodb_full_access" {
  name = "AmazonDynamoDBFullAccess"
}

# no ecr, servicediscovery or ecs policies available

data "aws_iam_policy" "elastic_load_balancing_full_access" {
  name = "ElasticLoadBalancingFullAccess"
}

data "aws_iam_policy" "aws_iam_full_access" {
  name = "IAMFullAccess"
}

data "aws_iam_policy" "aws_logs_full_access" {
  name = "CloudWatchLogsFullAccess"
}

data "aws_iam_policy" "aws_s3_full_access" {
  name = "AmazonS3FullAccess"
}

data "aws_iam_policy" "amazon_route53_full_access" {
  name = "AmazonRoute53FullAccess"
}

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
    "ecr:GetAuthorizationToken",
    "ecr:BatchGetImage",
    "ecr:BatchCheckLayerAvailability",
    "ecr:CreateRepository",
    "ecr:DescribeRepositories",
    "ecr:DescribeImages",
    "ecr:GetDownloadUrlForLayer",
    "ecr:InitiateLayerUpload",
    "ecr:ListTagsForResource",
    "ecr:ListImages",
    "ecr:PutImage",
    "ecr:UploadLayerPart",
    "ecr:CompleteLayerUpload",
    "ecr:TagResource",
    "ecs:CreateCluster",
    "ecs:DescribeClusters",
    "ecs:DescribeTaskDefinition",
    "ecs:DescribeServices",
    "ecs:UpdateService",
    "ecs:TagResource",
    "ecs:CreateService",
    "ecs:RegisterTaskDefinition",
    "servicediscovery:GetNamespace",
    "servicediscovery:ListTagsForResource",
    "servicediscovery:GetService",
    "servicediscovery:CreatePrivateDnsNamespace",
    "servicediscovery:TagResource",
    "servicediscovery:GetOperation",
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
  managed_policy_arns = [
    aws_iam_policy.github.arn,
    data.aws_iam_policy.amazon_vpc_full_access.arn,
    data.aws_iam_policy.amazon_ec2_full_access.arn,
    data.aws_iam_policy.aws_appmesh_full_access.arn,
    data.aws_iam_policy.amazon_dynamodb_full_access.arn,
    data.aws_iam_policy.elastic_load_balancing_full_access.arn,
    data.aws_iam_policy.aws_iam_full_access.arn,
    data.aws_iam_policy.aws_logs_full_access.arn,
    data.aws_iam_policy.aws_s3_full_access.arn,
    data.aws_iam_policy.amazon_route53_full_access.arn,
  ]
  assume_role_policy = data.aws_iam_policy_document.github_assume_role.json
}
