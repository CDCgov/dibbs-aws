resource "kubernetes_service_account" "eks_ecr_access_sa" {
  metadata {
    name      = "eks-ecr-access-sa"
    namespace = "$dibbs-aws-${terraform.workspace}"
  }

  automount_service_account_token = true
}

resource "kubernetes_role" "eks_ecr_access_role" {
  metadata {
    name      = "eks-ecr-access-role"
    namespace = "$dibbs-aws-${terraform.workspace}"
  }

  rule {
    api_groups = [""]
    resources  = ["secrets"]
    verbs      = ["get", "create"]
  }
}

resource "kubernetes_role_binding" "eks_ecr_access_role_binding" {
  metadata {
    name      = "eks-ecr-access-role-binding"
    namespace = "$dibbs-aws-${terraform.workspace}"
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "Role"
    name      = kubernetes_role.eks_ecr_access_role.metadata[0].name
  }

  subject {
    kind      = "ServiceAccount"
    name      = kubernetes_service_account.eks_ecr_access_sa.metadata[0].name
    namespace = kubernetes_service_account.eks_ecr_access_sa.metadata[0].namespace
  }
}
