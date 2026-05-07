# Root configuration: orchestrates network, storage, and compute modules.
# Modules are sourced directly from the aide-infra repository.

terraform {
  required_version = ">= 1.6.0"
  required_providers {
    aws = { source = "hashicorp/aws", version = "~> 5.0" }
  }
}

provider "aws" {
  region = var.aws_region
  default_tags {
    tags = {
      Project     = var.project
      Environment = var.environment
      ManagedBy   = "terraform"
    }
  }
}

# 1. Network: must be provisioned first
module "network" {
  source       = "git::https://github.com/SundaramDiraviam/aide-infra.git//modules/network?ref=main"
  project      = var.project
  environment  = var.environment
  aws_region   = var.aws_region
  vpc_cidr     = var.vpc_cidr
  cluster_name = var.cluster_name
}

# 2. Storage: ECR, S3, and KMS keys (independent of network)
module "storage" {
  source      = "git::https://github.com/SundaramDiraviam/aide-infra.git//modules/storage?ref=main"
  project     = var.project
  environment = var.environment
  aws_region  = var.aws_region
}

# 3. Compute: EKS cluster, node groups, Pod Identity (depends on network)
module "compute" {
  source             = "git::https://github.com/SundaramDiraviam/aide-infra.git//modules/compute?ref=main"
  project            = var.project
  environment        = var.environment
  aws_region         = var.aws_region
  cluster_name       = var.cluster_name
  kubernetes_version = var.kubernetes_version
  vpc_id             = module.network.vpc_id
  private_subnet_ids = module.network.private_subnet_ids
  public_subnet_ids  = module.network.public_subnet_ids
  cluster_sg_id      = module.network.eks_cluster_sg_id
  node_sg_id         = module.network.eks_nodes_sg_id
  node_instance_type = var.node_instance_type
  node_min_size      = var.node_min_size
  node_max_size      = var.node_max_size

  depends_on = [module.network]
}
