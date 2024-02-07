data "aws_availability_zones" "available" {
  state = "available"
}
data "aws_elb_service_account" "main" {}

data "aws_caller_identity" "current" {}

data "aws_partition" "current" {}