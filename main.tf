locals {
  vpc_cidr = "10.0.0.0/16"
  azs = ["usw2-az1", "usw2-az2"]
  name = "eks-vpc"
  tags ={}
}
module "vpc" {
  source = "git@github.com:dev-sha-ops/terraform-aws-vpc//modules/vpc"

  name = local.name
  cidr = local.vpc_cidr

  azs             = local.azs
  private_subnets = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 4, k)]
  public_subnets  = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 8, k + 48)]

  enable_nat_gateway = true
  single_nat_gateway = true

  public_subnet_tags = {
    "kubernetes.io/role/elb" = 1
  }

  private_subnet_tags = {
    "kubernetes.io/role/internal-elb" = 1
  }

  tags = local.tags
}

module "eks_cluster" {
  source              = "./modules/eks-cluster"
  cluster_name        = "my-eks-cluster"
  subnet_ids          = module.vpc.private_subnets
  vpc_id              = module.vpc.vpc_id
  environment = "dev"
  kubernetes_version  = "1.31"
  tags = {}
  depends_on = [ module.vpc ]
}

module "eks_node_group" {
  source          = "./modules/eks-managed-node-group"
  cluster_name    = "my-eks-cluster"
  node_group_name = "my-node-group"
  subnet_ids      = module.vpc.private_subnets
  environment = "dev"
  desired_size    = 3
  min_size        = 1
  max_size        = 5
  tags = {
    "Environment" = "production"
  }
  depends_on = [ module.eks_cluster ]
}
