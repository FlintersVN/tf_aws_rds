locals {
  rds_db_sg = "${aws_security_group.default.id},${var.vpc_security_group_ids}"
}

locals {
  computed_major_engine_version = var.engine == "postgres" ? join(".", slice(split(".", var.engine_version), 0, 1)) : join(".", slice(split(".", var.engine_version), 0, 2))
  major_engine_version          = var.major_engine_version == "" ? local.computed_major_engine_version : var.major_engine_version
  list_vpc_security_group_ids   = var.vpc_security_group_ids != "" ? local.rds_db_sg : aws_security_group.default.id
}

resource "aws_db_instance" "default" {
  lifecycle {
    create_before_destroy = true
  }
  depends_on = [
    aws_security_group.default,
    aws_db_subnet_group.default,
    aws_db_option_group.default,
    aws_db_parameter_group.default,
  ]

  allocated_storage                   = var.allocated_storage
  max_allocated_storage               = var.max_allocated_storage
  storage_encrypted                   = var.storage_encrypted
  ca_cert_identifier                  = var.ca_cert_identifier
  license_model                       = var.license_model
  allow_major_version_upgrade         = var.allow_major_version_upgrade
  auto_minor_version_upgrade          = var.auto_minor_version_upgrade
  engine                              = var.engine
  engine_version                      = var.engine_version
  identifier                          = var.identifier
  instance_class                      = var.instance_class
  storage_type                        = var.storage_type
  iops                                = var.iops
  skip_final_snapshot                 = var.skip_final_snapshot
  copy_tags_to_snapshot               = var.copy_tags_to_snapshot
  name                                = var.db_name
  password                            = var.password
  username                            = var.username
  availability_zone                   = var.availability_zone
  backup_retention_period             = var.backup_retention_period
  backup_window                       = var.backup_window
  maintenance_window                  = var.maintenance_window
  deletion_protection                 = var.deletion_protection
  enabled_cloudwatch_logs_exports     = var.enabled_cloudwatch_logs_exports
  iam_database_authentication_enabled = var.iam_database_authentication_enabled
  multi_az                            = var.multi_az
  port                                = var.port
  publicly_accessible                 = var.publicly_accessible
  snapshot_identifier                 = var.snapshot_identifier
  vpc_security_group_ids              = split(",", local.list_vpc_security_group_ids)
  db_subnet_group_name                = aws_db_subnet_group.default.id
  apply_immediately                   = var.apply_immediately

  performance_insights_enabled          = var.performance_insights_enabled
  performance_insights_kms_key_id       = var.performance_insights_enabled ? var.performance_insights_kms_key_id : null
  performance_insights_retention_period = var.performance_insights_enabled ? var.performance_insights_retention_period : null

  parameter_group_name = length(var.parameter_group_name) > 0 ? var.parameter_group_name : join("", aws_db_parameter_group.default.*.name)
  option_group_name    = length(var.option_group_name) > 0 ? var.option_group_name : join("", aws_db_option_group.default.*.name)

  monitoring_interval = var.monitoring_interval
  monitoring_role_arn = var.monitoring_role_arn

  tags = merge(
    {
      "Name" = var.identifier
    },
    var.tags,
  )
}

