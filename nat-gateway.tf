#1.1 Creating an Elastic IP 1
resource "aws_ip" "eip-for-nat-gateway-1" {
    vpc = true

    tag = {
        Name = "EIP 1" 
    }
} 
#1.2 Creating an Elastic IP 2
resource "aws_ip" "eip-for-nat-gateway-2" {
    vpc = true

    tag = {
        Name = "EIP 2"
    }  
}

#2.1 Create a NAT gateway 1
resource "aws_nat_gateway" "nat-gateway-1" {
    allocation_id = aws_ip.eip-for-nat-gateway-1.id
    subnet_id = aws_subnet.public-subnet-1.id

    tags = {
      Name = "Nat Gateway in Public Subnet 1"
    }  
}
# 2.2 Create a NAT gateway 2
resource "aws_nat_gateway" "nat-gateway-2" {
    allocation_id = aws_ip.eip-for-nat-gateway-2.id
    subnet_id = aws_subnet.public-subnet-2.id

    tags = {
        Name = "NAT Gateway in Public Subnet 2"
    }
  
}
