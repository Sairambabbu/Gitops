resource "aws_ecr_repository" "frontend" { name = "${var.cluster_name}-frontend" }
resource "aws_ecr_repository" "backend" { name = "${var.cluster_name}-backend" }
