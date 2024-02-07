module "s3_bucket" {
  for_each = toset(local.s3_buckets)
  source   = "terraform-aws-modules/s3-bucket/aws"
  version  = "~> 3.0"

  bucket                                = "${local.name}-${each.key}-${local.account_id}"
  block_public_acls                     = true
  block_public_policy                   = true
  restrict_public_buckets               = true
  ignore_public_acls                    = true
  attach_policy                         = true
  attach_require_latest_tls_policy      = true
  attach_deny_insecure_transport_policy = true
  # logging = {
  #   target_bucket = local.access_logging_bucket
  #   target_prefix = "s3/${var.namespace}-${terraform.workspace}-${each.key}-${local.account_id}"
  # }
  server_side_encryption_configuration = {
    rule = {
      apply_server_side_encryption_by_default = {
        sse_algorithm = "AES256"
      }
    }
  }
  versioning = {
    enabled = true
  }
}

locals {
  s3_buckets = []
}