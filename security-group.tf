# Security Group for the load Balancer
resource "aws_security_group" "alb-security-group" {
    name = "AlB Security Group" 
    description = "This ALB Security Group is gonna accept traffic from port 80/443 (HTTP/HTTPS)"
    vpc_id = aws_vpc.vpc.id
    
    ingress {

    }
  
}