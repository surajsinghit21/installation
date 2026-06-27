resource "helm_release" "alb" {
  name = "aws-load-balancer-controller"
  repository = "https://aws.github.io/eks-charts"

  chart = "aws-load-balancer-controller"

  namespace = "kube-system"

  set = [ {
    name = "clusterName"
    value = aws_eks_cluster.eks.name
  },{
    name = "serviceAccount.create"
    value = "false"
  },{
    name = "serviceAccount.name"
    value = kubernetes
  },{
    name = "region"
    value = "ap-south-1"
  },
  {
    name = "vpcId"
    value = data.default.vpcId
  } ]

  depends_on = [ kubernetes_api_service_v1.alb_sa ]
}