module "networking" {
  source             = "./modules/networking"
  vpc_name           = "e2e-ms-vpc"
  vpc_cidr           = "10.0.0.0/16"
  availability_zones = ["us-east-1a", "us-east-1b", "us-east-1c"]
  private_subnets    = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets     = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
  database_subnets   = ["10.0.201.0/24", "10.0.202.0/24", "10.0.203.0/24"]
}

module "eks" {
  source             = "./modules/eks"
  cluster_name       = "e2e-ms-cluster"
  vpc_id             = module.networking.vpc_id
  private_subnet_ids = module.networking.private_subnets
}

module "rds" {
  source               = "./modules/rds"
  vpc_id               = module.networking.vpc_id
  db_subnet_group_name = module.networking.database_subnet_group_name
  eks_node_sg_id       = module.eks.node_security_group_id # Now this works!
}