resource "aws_secretsmanager_secret" "db" {
  name = "/${var.cluster_name}/db"
}

resource "aws_secretsmanager_secret_version" "db_v" {
  secret_id = aws_secretsmanager_secret.db.id
  secret_string = jsonencode({
    username = var.db_username
    password = var.db_password
    host     = module.db.db_instance_address
    port     = module.db.db_instance_port
    dbname   = var.db_name
  })
}
