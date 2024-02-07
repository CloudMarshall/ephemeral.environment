module "ecs" {
  source                                = "terraform-aws-modules/ecs/aws"
  version                               = "~> 4.0"
  cluster_name                          = "${local.name}-cluster"
  default_capacity_provider_use_fargate = true

  cluster_settings = {
    "name" : "containerInsights",
    "value" : "enabled"
  }
  fargate_capacity_providers = {
    FARGATE      = {}
    FARGATE_SPOT = {}
  }
}