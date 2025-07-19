module "db" {
  source  = "terraform-aws-modules/rds/aws"
  version = "~> 6.5"

  identifier = "${var.cluster_name}-pg"

  engine         = "postgres"
  engine_version = "16"
  family         = "postgres16"

  instance_class    = "db.t3.micro"
  allocated_storage = 20

  db_name  = var.db_name
  username = var.db_username
  password = var.db_password

  subnet_ids             = data.aws_subnets.default.ids
  vpc_security_group_ids = [aws_security_group.rds_open.id]
  publicly_accessible    = true
  skip_final_snapshot    = true

  tags = {
    Environment = "dev"
  }

  depends_on = [aws_security_group.rds_open]
}
