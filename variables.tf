variable "region" {
  description = "AWS Region"
  type        = string
}

variable "namespace" {
  description = "Default Namespace for Resources"
  default     = "hb-sec"
  type        = string
}

variable "environment" {
  description = "Environment"
  type = string
}

variable "vpc_cidr" {
  description = "VPC CIDR Block"
  type        = string
}
variable "public_subnet_cidrs" {
  description = "List of Public Subnet CIDR Blocks"
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "List of Public Subnet CIDR Blocks"
  type        = list(string)
}

variable "database_subnet_cidrs" {
  description = "List of Public Subnet CIDR Blocks"
  type        = list(string)
}

variable "aws_waf_rulesets" {
  description = "List of AWS Managed Rule Sets and Excluded rules"
  default = {
    AWSManagedRulesCommonRuleSet        = {
      rule_action_override = {}
    },
    "AWSManagedRulesLinuxRuleSet"           = {
      rule_action_override = {}
    },
    "AWSManagedRulesSQLiRuleSet"            = {
      rule_action_override = {}
    },
    "AWSManagedRulesPHPRuleSet"             = {
      rule_action_override = {}
    },
    "AWSManagedRulesBotControlRuleSet"      = {
      rule_action_override = {}
    },
    "AWSManagedRulesKnownBadInputsRuleSet"  = {
      rule_action_override = {}
    },
    "AWSManagedRulesAmazonIpReputationList" = {
      rule_action_override = {}
    },
  }
}
