#create cluser role for interacting with aws services
variable "cluster_role_name" {}

resource "aws_iam_role" "demo-eks-cluster-service-role"{
  name = var.cluster_role_name
  assume_role_policy = file("modules/eks/policies/iam-assume-role.json")
  managed_policy_arns = ["arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"]
}
