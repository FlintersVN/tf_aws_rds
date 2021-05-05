resource "aws_security_group" "default" {
  lifecycle {
    create_before_destroy = true
  }
  name        = "${var.identifier}-sg"
  description = "Managed by Terraform"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "TCP"
    cidr_blocks = split(",", var.allowed_ips)
  }

  tags = merge(
    {
      "Name" = "${var.identifier}-sg"
    },
    var.tags,
  )
}

