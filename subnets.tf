#--------------------------------------------------------------
# This module creates all resources necessary for a rds_db
# subnet
#--------------------------------------------------------------

resource "aws_db_subnet_group" "default" {
  name        = "${var.identifier}_subnet_group"
  description = "Managed by Terraform"
  subnet_ids  = var.subnet_ids
  tags = merge(
    {
      "Name" = "${var.identifier}_subnet_group"
    },
    var.tags,
  )
}

