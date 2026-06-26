resource "aws_eks_cluster" "eks" {
  name = "eks-cluster-tf"
  role_arn = aws_iam_role.eks_cluster_role.arn

  vpc_config {
    subnet_ids = data.aws_subnets.default.ids
  }

  depends_on = [ aws_iam_role_policy_attachment.eks_policy ]
}


resource "aws_eks_node_group" "nodes" {
  cluster_name = aws_eks_cluster.eks.name
  node_group_name = "eks-node-tf"
  node_role_arn = aws_iam_role.eks_node_role.arn
  subnet_ids = data.aws_subnets.default.ids

  scaling_config {
    desired_size = 2
    max_size = 2
    min_size = 1
  }

  instance_types = ["t3.medium"]

  depends_on = [
    aws_iam_role_policy_attachment.worker_node_policy,
    aws_iam_role_policy_attachment.cni_policy,
    aws_iam_role_policy_attachment.ecr_policy
   ]
}