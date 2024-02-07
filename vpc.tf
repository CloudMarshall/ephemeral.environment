module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.0"
  name    = "${local.name}-vpc"
  cidr    = var.vpc_cidr

  azs                                = [data.aws_availability_zones.available.names[0], data.aws_availability_zones.available.names[1], data.aws_availability_zones.available.names[2]]
  private_subnets                    = var.private_subnet_cidrs
  public_subnets                     = var.public_subnet_cidrs
  database_subnets                   = var.database_subnet_cidrs
  enable_nat_gateway                 = false // DISABLING DUE CENTRALIZED NAT OVER TGW
  enable_vpn_gateway                 = false
  map_public_ip_on_launch            = false
  manage_default_security_group      = true
  enable_dhcp_options                = true
  enable_dns_hostnames               = true
  enable_dns_support                 = true
  create_database_subnet_route_table = true

  enable_flow_log                           = false
  create_flow_log_cloudwatch_iam_role       = true
  create_flow_log_cloudwatch_log_group      = true
  flow_log_cloudwatch_log_group_name_prefix = "${local.name}-vpclogs"
  default_security_group_egress             = []
  default_security_group_ingress            = []
}