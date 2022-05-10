terraform {
  backend "s3" {
    bucket  = "nsharmawheel-demo"
    key     = "statefiles/demo.tfstate"
    region  = "us-east-2"
    encrypt = true
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region  = "us-east-2"
}

module "eks" {
  source = "./modules/eks"
  eks_cluster_name = "wheeldemo-cluster"
  eks_role_arn = "arn:aws:iam::613313135663:role/demo-eks-cluster-service-role"
  eks_subnets = ["subnet-017f14205ffd442ec","subnet-0c3d3400ca8cb14f3","subnet-0004e3bb27b1dd833"]
  eks_cluster_sg = ["sg-0d23583a03b4362ba"]
  #eks_subnets = ["subnet-0c1af165db798bc43","subnet-09573364cd85af527","subnet-0980c948ff3a14b05","subnet-0e2310c8baddf0935","subnet-004476815c8d6ebfb","subnet-0889d6a71ca22a85e"]
  cluster_role_name = "demo-eks-cluster-service-role"
  pod_role_name = "demo-eks-fargate-role"
  fargate_subnets = ["subnet-0621e4bf95d8c2039","subnet-0ccfa8490127134ad","subnet-01284d1dd8c8ff8aa"]
}

module "vpc" {
  source = "./modules/vpc"
  cluster_name = "wheeldemo-cluster"
}

