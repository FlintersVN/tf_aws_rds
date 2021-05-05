resource "aws_route53_record" "default" {

  count = length(var.zone_id) > 0 ? 1 : 0

  name    = var.identifier
  ttl     = var.ttl
  type    = var.type
  zone_id = var.zone_id

  records = [
    aws_db_instance.default.address,
  ]
}
