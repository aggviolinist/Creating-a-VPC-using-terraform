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
#2.2 Create a NAT gateway 2
resource "aws_nat_gateway" "nat-gateway-2" {
    allocation_id = aws_ip.eip-for-nat-gateway-2.id
    subnet_id = aws_subnet.public-subnet-2.id

    tags = {
        Name = "NAT Gateway in Public Subnet 2"
    }
  
}

#3.1 Create a Private Route Table 1 and route via NAT gateway 1
resource "aws_route_table" "private-route-table-1" {
    vpc_id = aws_vpc.vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.nat-gateway-1.id
    
    }
    tags = {
      Name = "Private Route Table 1"
    }
  
}
#3.2 Create a Private Route Table 2 and route via NAT gateway 2
resource "aws_route_table" "private-route-table-2" {
    vpc_id = aws_vpc.vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.nat-gateway-2.id
    }
    tags = {
        Name = "Private Route Table 2"
    }
  
}
#4.1 Associate the Route tables to the Private Subnets 

