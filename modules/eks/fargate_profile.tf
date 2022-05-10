#create fargate pools to run worker nodes and app containers 
#with no match_labels, all workloads will be captured in a namespace to run in fargate
variable "pod_role_name" {}
variable "fargate_subnets" {}

resource "aws_iam_role" "demo-eks-fargate-service-role"{
  name = var.pod_role_name
  assume_role_policy = file("modules/eks/policies/iam-assume-role-fargate.json")
  managed_policy_arns = ["arn:aws:iam::aws:policy/AmazonEKSFargatePodExecutionRolePolicy"]
}

resource "aws_eks_fargate_profile" "demo-fargate" {
  cluster_name           = aws_eks_cluster.demo-eks-cluster.name
  fargate_profile_name   = "demo-fargate-profile"
  pod_execution_role_arn = aws_iam_role.demo-eks-fargate-service-role.arn
  subnet_ids             = var.fargate_subnets

  selector {
    namespace = "demo"
  }

  selector {
    namespace = "kube-system"
  }

}

