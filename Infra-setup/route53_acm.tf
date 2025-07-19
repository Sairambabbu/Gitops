# Create Hosted Zone
resource "aws_route53_zone" "root" {
  name = var.domain_root
}

# Full domain = subdomain 

# ACM Certificate for subdomain
resource "aws_acm_certificate" "tls" {
  domain_name       = local.full_domain
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = local.full_domain
  }

  depends_on = [aws_route53_zone.root]
}

# DNS Records for ACM Validation
resource "aws_route53_record" "cert_validation" {
  for_each = {
    for dvo in aws_acm_certificate.tls.domain_validation_options :
    dvo.domain_name => {
      name  = dvo.resource_record_name
      type  = dvo.resource_record_type
      value = dvo.resource_record_value
    }
  }

  zone_id = aws_route53_zone.root.zone_id
  name    = each.value.name
  type    = each.value.type
  ttl     = 60
  records = [each.value.value]

  depends_on = [aws_acm_certificate.tls]
}

# Optional: Route53 CNAME for frontend once ALB is deployed
# resource "aws_route53_record" "cname_app" {
#   zone_id = aws_route53_zone.root.zone_id
#   name    = local.full_domain
#   type    = "CNAME"
#   ttl     = 300
#   records = ["<ALB-DNS-NAME>"]  # Replace with actual ALB DNS from Helm output
# }
