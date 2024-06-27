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
      values = ["sts.amazonaws.com",]
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
        # "appmesh:DescribeMesh",
        # "appmesh:ListTagsForResource",
        # "appmesh:DescribeVirtualNode",
        # "appmesh:DescribeVirtualService",
        # "dynamodb:GetItem",
        # "dynamodb:PutItem",
        # "dynamodb:DeleteItem",
        # "ec2:DescribeAddresses",
        # "ec2:DescribeVpcs",
        # "ec2:DescribeVpcAttribute",
        # "ec2:DescribeSubnets",
        # "ec2:DescribeRouteTables",
        # "ec2:DescribeInternetGateways",
        # "ec2:DescribeSecurityGroups",
        # "ec2:DescribeNetworkAcls",
        # "ec2:DescribeAddress",
        # "ec2:DescribeSecurityGroupRules",
        # "ec2:DescribeFlowLogs",
        # "ec2:DescribeNatGateways",
        # "ecr:GetAuthorizationToken",
        # "ecr:DescribeRepositories",
        # "ecr:ListTagsForResource",
        # "ecs:DescribeClusters",
        # "ecs:DescribeTaskDefinition",
        # "ecs:DescribeServices",
        # "elasticloadbalancing:DescribeTargetGroups",
        # "elasticloadbalancing:DescribeLoadBalancers",
        # "elasticloadbalancing:DescribeTargetGroupAttributes",
        # "elasticloadbalancing:DescribeLoadBalancerAttributes",
        # "elasticloadbalancing:DescribeTags",
        # "elasticloadbalancing:DescribeListeners",
        # "elasticloadbalancing:DescribeRules",
        # "iam:GetRole",
        # "iam:GetPolicy",
        # "iam:ListRolePolicies",
        # "iam:GetPolicyVersion",
        # "iam:ListAttachedRolePolicies",
        # "logs:DescribeLogGroups",
        # "logs:ListTagsLogGroup",
        # "s3:listBucket",
        # "s3:PutObject",
        # "s3:PutObjectAcl",
        # "s3:GetObject",
        # "s3:GetObjectAcl",
        # "s3:GetObjectAttributes",
        # "servicediscovery:GetNamespace",
        # "servicediscovery:ListTagsForResource",
        # "servicediscovery:GetService",
    ]
    resources = [
      "*"
        # aws_dynamodb_table.tfstate_lock.arn,
        # "${aws_dynamodb_table.tfstate_lock.arn}/*",
        # aws_s3_bucket.tfstate.arn,
        # "${aws_s3_bucket.tfstate.arn}/*",
        # "arn:aws:ec2:::",
        # "arn:aws:ecr:${var.region}:${data.aws_caller_identity.current.account_id}:repository/*",
        # "arn:aws:ecs:${var.region}:${data.aws_caller_identity.current.account_id}:cluster/*",
        # "arn:aws:logs:${var.region}:${data.aws_caller_identity.current.account_id}:log-group::*",
        # "arn:aws:appmesh:${var.region}:${data.aws_caller_identity.current.account_id}:mesh/*"
    ]
  }
}

resource "aws_iam_policy" "github" {
  name        = "${var.project}-github-policy-${var.owner}-${random_string.setup.result}"
  policy      = data.aws_iam_policy_document.github.json
}

resource "aws_iam_role" "github" {
  name               = "${var.project}-github-role-${var.owner}-${random_string.setup.result}"
  assume_role_policy = data.aws_iam_policy_document.github_assume_role.json
}

resource "aws_iam_role_policy_attachment" "github" {
  role       = aws_iam_role.github.name
  policy_arn = aws_iam_policy.github.arn
}
