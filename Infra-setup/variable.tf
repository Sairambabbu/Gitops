variable "aws_region" { default = "us-east-1" }
variable "cluster_name" { default = "creations-prod" }
variable "vpc_cidr" { default = "10.0.0.0/16" }
variable "azs" { default = ["us-east-1a", "us-east-1b"] }
variable "public_subnet_cidrs" { default = ["10.0.1.0/24", "10.0.2.0/24"] }
variable "private_subnet_cidrs" { default = ["10.0.3.0/24", "10.0.4.0/24"] }

variable "node_instance_type" { default = "t3.medium" }
variable "node_desired" { default = 3 }

variable "db_name" { default = "creations" }
variable "db_username" { default = "appuser" }
variable "db_password" { default = "appuser" }

variable "domain_root" { default = "manulikhi.com" }
variable "subdomain" { default = "creations" }
