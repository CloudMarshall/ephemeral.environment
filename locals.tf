locals {

  account_id = data.aws_caller_identity.current.account_id
  partition  = data.aws_partition.current.id
  name = "${var.namespace}-${var.environment}"

  aws_waf_rules = [for k, v in var.aws_waf_rulesets : {
    name            = "${local.name}-${k}"
    override_action = "block"
    priority        = index(keys(var.aws_waf_rulesets), k)

    statement = {
      name          = k
      vendor_name   = "AWS"
      rule_action_override = {for x, y in v.rule_action_override : x => y }
    }

    visibility_config = {
      cloudwatch_metrics_enabled = true
      sampled_requests_enabled   = true
      metric_name                = "waf-${local.name}-${k}-logs"
    }
  }]

  ssl_certificate_arns = []


  default_tags = {
    "hb_sec:managedby"   = "terraform"
    "hb_sec:environment" = var.environment
    "hb_sec:git"         = ""
  }

}