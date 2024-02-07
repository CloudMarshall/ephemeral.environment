module "waf" {
  source  = "cloudposse/waf/aws"
  version = "~> 1.0"

  name                               = "${var.namespace}-${terraform.workspace}-WAF"
  description                        = "${var.namespace} - ${terraform.workspace} Web Application Firewall"
  environment                        = terraform.workspace
  label_order                        = ["name", "environment"]
  scope                              = "REGIONAL"
  managed_rule_group_statement_rules = local.aws_waf_rules
  association_resource_arns          = [module.alb.lb_arn]
  default_action                     = "allow"
  rule_group_reference_statement_rules = []
  ip_set_reference_statement_rules = []
  visibility_config = {
    cloudwatch_metrics_enabled = true
    metric_name                = "${var.namespace}-${terraform.workspace}-WAF-logs"
    sampled_requests_enabled   = true
  }
}