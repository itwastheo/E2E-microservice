# Create the Security Group specifically for RDS
resource "aws_security_group" "rds_sg" {
  name        = "rds-security-group"
  description = "Allow inbound traffic from EKS worker nodes only"
  vpc_id      = var.vpc_id

  ingress {
    description     = "PostgreSQL from EKS"
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [var.eks_node_sg_id] # Handshake with EKS
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

module "db" {
  source  = "terraform-aws-modules/rds/aws"
  version = "~> 6.0"

  identifier = "e2e-ms-db"

  engine            = "postgres"
  engine_version    = "15.14"      # This is safer and more robust for IaC
  family            = "postgres15" # <--- ADD THIS LINE
  instance_class    = "db.t3.micro"
  major_engine_version = "15"
  allocated_storage = 20

  db_name  = "microservices"
  username = "postgres"
  port     = "5432"

  db_subnet_group_name   = var.db_subnet_group_name
  vpc_security_group_ids = [aws_security_group.rds_sg.id] # Use the SG we just defined

  manage_master_user_password = true # AWS will manage the password in Secrets Manager
  skip_final_snapshot         = true
  publicly_accessible         = false
}