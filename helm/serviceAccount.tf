resource "kubernetes_api_service_v1" "alb_sa" {
  metadata {
    name = "aws-load-balancer-controller"
    namespace = "kube-system"
    annotations = {
      "      "eks.amazonaws.com/role-arn" = aws_iam_role.alb.arn"
    }
  }
}