module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "~> 8.0"

  name = "${local.name}-alb"

  load_balancer_type = "application"

  vpc_id                           = module.vpc.vpc_id
  subnets                          = module.vpc.public_subnets
  internal                         = false
  security_groups                  = [module.alb_sg.security_group_id]
  drop_invalid_header_fields       = true
  enable_cross_zone_load_balancing = true
  enable_http2                     = true
  listener_ssl_policy_default      = "ELBSecurityPolicy-TLS-1-2-2017-01"
 # extra_ssl_certs                  = local.ssl_certificate_arns
  enable_deletion_protection       = false
  create_security_group            = false
  # access_logs = {
  #   bucket = module.s3_bucket.s3_bucket_id
  # }

  # https_listeners = [
  #   {
  #     port            = 443
  #     protocol        = "HTTPS"
  #     certificate_arn = data.terraform_remote_state.global.outputs.map_of_wildcard_acm_certificate_arns["ihfsaas.com"]
  #     action_type     = "fixed-response"
  #     fixed_response = {
  #       content_type = "text/plain"
  #       message_body = "HEALTHY"
  #       status_code  = "200"
  #     }
  #   }
  # ] DISABLING FOR NOW AS NOT CERTIFICATE OR DOMAIN INFORMATION

  http_tcp_listeners = [
    {
      port        = 80
      protocol    = "HTTP"
      action_type = "redirect"
      redirect = {
        port        = "443"
        protocol    = "HTTPS"
        status_code = "HTTP_301"
      }
    }
  ]
}




module "alb_sg" {

  #checkov:skip=CKV2_AWS_5:SG Group is attached to the ALB
  source  = "terraform-aws-modules/security-group/aws"
  version = "4.13.0"

  name                = "${local.name}-alb-sg"
  description         = "${local.name} ALB SG"
  vpc_id              = module.vpc.vpc_id
  egress_rules        = ["all-all"]
  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["https-443-tcp", "http-80-tcp"]
}
