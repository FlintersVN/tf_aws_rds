module "rds_instance" {
  source = "git::https://github.com/FlintersVN/tf_aws_rds.git?ref=develop"

  identifier  = "test"
  port        = "3306"
  allowed_ips = "10.23.1.0/24"
  db_name     = "test"
  username    = "test"
  password    = ""

  allocated_storage     = 50
  max_allocated_storage = 200
  storage_encrypted     = true
  engine                = "mysql"
  engine_version        = "8.0"
  instance_class        = "db.t3.micro"
  db_parameter_group    = "mysql8.0"
  publicly_accessible   = false
  subnet_ids            = ["subnet-0c3d1f95f68bbc443", "subnet-01d74bb062d645663"]
  vpc_id                = "vpc-9ab640fcsdfsd"

  db_parameter = [
    { name         = "character_set_server"
      value        = "utf8mb4"
      apply_method = "pending-reboot"
    },
    { name         = "character_set_client"
      value        = "utf8mb4"
      apply_method = "pending-reboot"
    },
    { name         = "collation_server"
      value        = "utf8mb4_general_ci"
      apply_method = "pending-reboot"
    },
    { name         = "character_set_database"
      value        = "utf8mb4"
      apply_method = "pending-reboot"
    },
    { name         = "character_set_results"
      value        = "utf8mb4"
      apply_method = "pending-reboot"
    },
    { name         = "character_set_connection"
      value        = "utf8mb4"
      apply_method = "pending-reboot"
    },
    { name         = "key_buffer_size"
      value        = "16777216"
      apply_method = "pending-reboot"
    },
    { name         = "table_open_cache"
      value        = "2000"
      apply_method = "pending-reboot"
    },
    { name         = "innodb_sort_buffer_size"
      value        = "1048576"
      apply_method = "pending-reboot"
    },
    { name         = "read_buffer_size"
      value        = "262144"
      apply_method = "pending-reboot"
    },
    { name         = "time_zone"
      value        = "Asia/Tokyo"
      apply_method = "immediate"
    },
    { name         = "slow_query_log"
      value        = "1"
      apply_method = "pending-reboot"
    },
    { name         = "long_query_time"
      value        = "2"
      apply_method = "pending-reboot"
    },
    { name         = "general_log"
      value        = "1"
      apply_method = "pending-reboot"
    },
  ]
}
