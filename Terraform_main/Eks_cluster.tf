# provider "aws" {
#   region = var.aws_region
# }
module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  version         = "~> 20.0"
  cluster_name    = var.cluster_name
  cluster_version = var.kubernetes_version
  subnet_ids      = module.vpc.private_subnets
  cluster_endpoint_public_access = true

  enable_irsa = true

  tags = {
    cluster = "capstone_project"
  }

  vpc_id = module.vpc.vpc_id

  eks_managed_node_group_defaults = {
    ami_type               = "AL2_x86_64"
    vpc_security_group_ids = [aws_security_group.sock-shop.id]
  }

  eks_managed_node_groups = {

    node_group_one = {

      name         = "node-group-one"
      instance_type = ["t2.medium"]
      min_size     = 1
      max_size     = 2
      desired_size = 2
    }

     node_group_two = { 

      name         = "node-group-two"
      instance_type = ["t2.medium"]
      min_size     = 1
      max_size     = 2
      desired_size = 2
    }
  }
  # Cluster access entry
  enable_cluster_creator_admin_permissions = true
}