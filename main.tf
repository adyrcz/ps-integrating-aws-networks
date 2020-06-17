provider "aws" {
  region = "eu-west-1"
  profile = "default"
}

data "aws_security_group" "default" {
  name   = "default"
  vpc_id = module.vpc.vpc_id
}

module "vpc" {
  source = "./modules/"

  name = "Globomantics"

  private_zone_name = "globomantics.com"

  enable_dhcp_options              = true
  dhcp_options_domain_name         = "globomantics.com"

  cidr = "10.0.0.0/16"

  enable_dns_hostnames = true
  enable_dns_support   = true

  azs                 = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
  public_subnets      = ["10.0.0.0/20", "10.0.16.0/20", "10.0.32.0/20"]
  private_subnets     = ["10.0.48.0/20", "10.0.64.0/20", "10.0.80.0/20"]

  enable_flow_log                      = true
  create_flow_log_cloudwatch_log_group = true
  create_flow_log_cloudwatch_iam_role  = true
  enable_ipv6 = true
  enable_nat_gateway = true
  single_nat_gateway = true
  public_subnet_tags = {
    Name = "Globomantics-public"
  }

  tags = {
    Owner       = "Globomantics"
    Environment = "production"
  }

  vpc_tags = {
    Name = "globomantics-production"
  }
}
