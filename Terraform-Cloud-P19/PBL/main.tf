# -----------root/main.tf-------------

##creating bucket for s3 backend

resource "aws_s3_bucket" "terraform-state" {
  bucket        = "lego-18-bucket"
  # force_destroy = true
}
resource "aws_s3_bucket_versioning" "versioning_terraform-state" {
  bucket = aws_s3_bucket.terraform-state.id
  versioning_configuration {
    status = "Enabled"
  }
}
resource "aws_s3_bucket_server_side_encryption_configuration" "first" {
  bucket = aws_s3_bucket.terraform-state.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_dynamodb_table" "terraform_locks" {
  name         = "terraform-locks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
}

# creating VPC
module "VPC" {
  source                             = "./modules/VPC"
  region                             = var.region
  vpc_cidr                           = var.vpc_cidr
  enable_dns_support                 = var.enable_dns_support
  enable_dns_hostnames               = var.enable_dns_hostnames
  preferred_number_of_public_subnet  = var.preferred_number_of_public_subnet
  preferred_number_of_private_subnet = var.preferred_number_of_private_subnet
  private_subnet                     = [for i in range(1, 8, 2) : cidrsubnet(var.vpc_cidr, 8, i)]
  public_subnet                      = [for i in range(2, 5, 2) : cidrsubnet(var.vpc_cidr, 8, i)]
}

#Module for Application Load balancer, this will create Extenal Load balancer and internal load balancer
module "ALB" {
  source             = "./modules/ALB"
  name               = "lego-ext-alb"
  vpc_id             = module.VPC.vpc_id
  public-sg          = module.security.ext-alb-sg
  private-sg         = module.security.int-alb-sg
  public_subnet_1    = module.VPC.public_subnet_1
  public_subnet_2    = module.VPC.public_subnet_2
  private_subnet_1   = module.VPC.private_subnet_1
  private_subnet_2   = module.VPC.private_subnet_2
  load_balancer_type = "application"
  ip_address_type    = "ipv4"
}

module "security" {
  source = "./modules/security"
  vpc_id = module.VPC.vpc_id
}

module "Autoscaling" {
  source            = "./modules/Autoscaling"
  ami-web           = var.ami
  ami-bastion       = var.ami
  ami-nginx         = var.ami
  desired_capacity  = 2
  min_size          = 2
  max_size          = 2
  webserver-sg      = [module.security.webserver-sg]
  bastion-sg        = [module.security.bastion-sg]
  nginx-sg          = [module.security.nginx-sg]
  wordpress-alb-tgt = module.ALB.wordpress-tgt
  nginx-alb-tgt     = module.ALB.nginx-tgt
  tooling-alb-tgt   = module.ALB.tooling-tgt
  instance_profile  = module.VPC.instance_profile
  public_subnets    = [module.VPC.public_subnet_1, module.VPC.public_subnet_2]
  private_subnets   = [module.VPC.private_subnet_1, module.VPC.private_subnet_2]
  keypair           = var.keypair
}

# Module for Elastic Filesystem; this module will creat elastic file system isn the webservers availablity
# zone and allow traffic fro the webservers

module "EFS" {
  source       = "./modules/EFS"
  efs-subnet-1 = module.VPC.private_subnet_1
  efs-subnet-2 = module.VPC.private_subnet_2
  efs-sg       = [module.security.datalayer-sg]
  account_no   = var.account_no
}

# RDS module; this module will create the RDS instance in the private subnet

module "RDS" {
  source         = "./modules/RDS"
  db-password    = var.db-password
  db-username    = var.db-username
  db-sg          = [module.security.datalayer-sg]
  private_subnet = [module.VPC.private_subnet_3, module.VPC.private_subnet_4]
}

# The Module creates instances for jenkins, sonarqube abd jfrog
module "compute" {
  source          = "./modules/Compute"
  ami-jenkins     = var.ami
  ami-sonar       = var.ami
  ami-jfrog       = var.ami
  subnets-compute = module.VPC.public_subnet_1
  sg-compute      = [module.security.ext-alb-sg]
  keypair         = var.keypair
}
