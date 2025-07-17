# Creating a Database Subnet Group
resource "aws_db_subnet_group" "database-subnet-group" {
    name = "Database Subnets"
    subnet_ids = [aws_subnet.private-subnet-3.id,]
    description = "Database subnets with a master and standby"

    tags = {
      Name = "Database Subnets"
    } 
}

# Create an RDS instance
resource "aws_db_instance" "rds-db-instance" {
    
  
}
# Get the latest snapshot from the RDS 