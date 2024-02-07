output "vpc_id" {
  description = "VPC ID"
  value       = module.vpc.vpc_id
}

output "vpc_cidr_block" {
  description = "VPC ID"
  value       = module.vpc.vpc_cidr_block
}

output "public_subnet_ids" {
  description = "Public Subnet ID's"
  value       = module.vpc.public_subnets
}

output "private_subnet_ids" {
  description = "Public Subnet ID's"
  value       = module.vpc.private_subnets
}

output "database_subnet_ids" {
  description = "Database Subnet ID's"
  value       = module.vpc.database_subnets
}

output "database_subnet_group_id" {
  description = "Database Subnet Group ID"
  value       = module.vpc.database_subnet_group
}

output "database_subnet_group_name" {
  description = "Database Subnet Group Name"
  value       = module.vpc.database_subnet_group_name
}

output "public_subnet_cidr_blocks" {
  description = "Public Subnet CIDR Blocks"
  value       = module.vpc.public_subnets_cidr_blocks
}

output "private_subnet_cidr_blocks" {
  description = "Private Subnet CIDR Blocks"
  value       = module.vpc.private_subnets_cidr_blocks
}

output "database_subnet_cidr_blocks" {
  description = "Database Subnet CIDR Blocks"
  value       = module.vpc.database_subnets_cidr_blocks
}

output "ecs_cluster_id" {
  description = "ECS Cluster ID"
  value       = module.ecs.cluster_id
}

output "ecs_cluster_name" {
  description = "ECS Cluster Name"
  value       = module.ecs.cluster_name
}

output "ecs_cluster_arn" {
  description = "ECS Cluster ARN"
  value       = module.ecs.cluster_arn
}

output "alb_id" {
  description = "ALB ID"
  value       = module.alb.lb_id
}

output "alb_arn" {
  description = "ALB ARN"
  value       = module.alb.lb_arn
}

# output "alb_https_tcp_listener_arns" {
#   description = "ALB HTTPS TCP Listener ARN"
#   value       = module.alb.https_listener_arns[0]
# }

output "alb_http_tcp_listener_arns" {
  description = "ALB HTTP TCP Listener ARN"
  value       = module.alb.http_tcp_listener_arns[0]
}

output "alb_http_tcp_listener_ids" {
  description = "ALB HTTP TCP Listener ID"
  value       = module.alb.http_tcp_listener_ids[0]
}

# output "alb_https_tcp_listener_ids" {
#   description = "ALB HTTPS TCP Listener ID"
#   value       = module.alb.https_listener_ids[0]
# }

output "alb_dns_name" {
  description = "ALB DNS Endpoint"
  value       = module.alb.lb_dns_name
}

output "alb_sg_id" {
  description = "ALB SG ID"
  value       = module.alb_sg.security_group_id
}