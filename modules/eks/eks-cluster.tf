#a template for creating demo clusters, this resource can be made multiple times for different environments like dev/qa
#or one time feature environments
variable "eks_role_arn" {}
variable "eks_subnets" {}
variable "eks_cluster_name" {}
variable "eks_cluster_sg" {}

resource "aws_eks_cluster" "demo-eks-cluster" {
  name     = var.eks_cluster_name
  role_arn = var.eks_role_arn

  vpc_config {
    subnet_ids = var.eks_subnets
    security_group_ids = var.eks_cluster_sg
  }

}

output "endpoint" {
  value = aws_eks_cluster.demo-eks-cluster.endpoint
}

output "kubeconfig-certificate-authority-data" {
  value = aws_eks_cluster.demo-eks-cluster.certificate_authority[0].data
}
