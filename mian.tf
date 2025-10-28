module "vpc" {
  source       = "./modules/vpc"
  project_name = var.project_name
  cidr_block   = "10.0.0.0/16"
}

module "public_subnet" {
  source                  = "./modules/subnet"
  vpc_id                  = module.vpc.vpc_id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true
  subnet_type             = "public"
  project_name            = var.project_name
}
module "public_subnet_2" {
  source                  = "./modules/subnet"
  vpc_id                  = module.vpc.vpc_id
  cidr_block              = "10.0.3.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true
  subnet_type             = "public-2"
  project_name            = var.project_name
}
module "private_subnet" {
  source                  = "./modules/subnet"
  vpc_id                  = module.vpc.vpc_id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = false
  subnet_type             = "private"
  project_name            = var.project_name
}

module "nat_gateway" {
  source           = "./modules/nat"
  vpc_id           = module.vpc.vpc_id
  public_subnet_id = module.public_subnet.subnet_id
  project_name     = var.project_name
}

module "alb_security_group" {
  source       = "./modules/alb-sg"
  vpc_id       = module.vpc.vpc_id
  project_name = var.project_name
}

module "eic_endpoint_sg" {
  source       = "./modules/eic-endpoint-sg"
  vpc_id       = module.vpc.vpc_id
  project_name = var.project_name
}

module "ec2_connect_endpoint"  {
  source             = "./modules/eic-endpoint"
  private_subnet_id  = module.private_subnet.subnet_id
  eic_endpoint_sg_id = module.eic_endpoint_sg.eic_endpoint_sg_id
  project_name       = var.project_name
}

module "security_group" {
  source                = "./modules/security-group"
  vpc_id                = module.vpc.vpc_id
  project_name          = var.project_name
  alb_security_group_id = module.alb_security_group.sg_id
  eic_endpoint_sg_id    = module.eic_endpoint_sg.eic_endpoint_sg_id
}


module "ec2" {
  source       = "./modules/ec2"
  subnet_id    = module.private_subnet.subnet_id
  sg_id        = module.security_group.sg_id
  project_name = var.project_name
}

module "alb" {
  source       = "./modules/alb"
  project_name = var.project_name
  vpc_id       = module.vpc.vpc_id
  subnet_ids = [
    module.public_subnet.subnet_id,
    module.public_subnet_2.subnet_id
  ]
  alb_security_group_id = module.alb_security_group.sg_id
  instance_id           = module.ec2.instance_id
}


module "public_route_table" {
  source           = "./modules/route-table"
  vpc_id           = module.vpc.vpc_id
  subnet_id        = module.public_subnet.subnet_id
  route_table_type = "public"
  project_name     = var.project_name

  routes = [
    {
      cidr_block = "0.0.0.0/0"
      gateway_id = module.vpc.igw_id
    }
  ]
}

module "public_route_table_2" {
  source           = "./modules/route-table"
  vpc_id           = module.vpc.vpc_id
  subnet_id        = module.public_subnet_2.subnet_id
  route_table_type = "public-2"
  project_name     = var.project_name

  routes = [
    {
      cidr_block = "0.0.0.0/0"
      gateway_id = module.vpc.igw_id
    }
  ]
}

module "private_route_table" {
  source           = "./modules/route-table"
  vpc_id           = module.vpc.vpc_id
  subnet_id        = module.private_subnet.subnet_id
  route_table_type = "private"
  project_name     = var.project_name

  routes = [
    {
      cidr_block     = "0.0.0.0/0"
      nat_gateway_id = module.nat_gateway.nat_gateway_id
    }
  ]
}
