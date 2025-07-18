# Creating a Database Subnet Group
resource "aws_db_subnet_group" "database-subnet-group" {
  name        = "database-subnets"
  subnet_ids  = [aws_subnet.private-subnet-3.id, aws_subnet.private-subnet-4.id ]
  description = "Database subnets with a master and standby"

  tags = {
    Name = "Database Subnets"
  }
}

# Create an RDS instance
resource "aws_db_instance" "rds-db-instance" {
  instance_class         = var.database-instance-class
  skip_final_snapshot    = true
  availability_zone      = "us-east-1a"
  identifier             = var.database-instance-identifier
  snapshot_identifier    = data.aws_db_snapshot.latest-database-snapshot.id
  db_subnet_group_name   = aws_db_subnet_group.database-subnet-group.name
  multi_az               = false #"${var.multi-az-deployment}"
  vpc_security_group_ids = [aws_security_group.database-security-group.id]
}
# Get the latest snapshot from the RDS 
data "aws_db_snapshot" "latest-database-snapshot" {
  db_snapshot_identifier = var.database-snapshot-identifier
  most_recent            = true
  snapshot_type          = "manual"
}