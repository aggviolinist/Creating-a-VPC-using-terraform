#1. ALB Security Group
resource "aws_security_group" "alb-security-group" {
    name = "AlB Security Group" 
    description = "This ALB Security Group is gonna accept traffic from port 80/443 (HTTP/HTTPS)"
    vpc_id = aws_vpc.vpc.id
    
    ingress {
        description = "HTTP Access"
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        description = "HTTPS Access"
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags = {
        Name = "ALB Security Group"
    }
}
#2. Bastion Security Group
resource "aws_security_group" "SSH-bastion-security-group" {
    name = "Bastion SSH Security Access"
    description = "Port 22 Access"
    vpc_id = aws_vpc.vpc.id

    ingress {
        description = "Bastion SSH Access"
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["${var.ssh-location}"] 
        # IP address that can ssh into my ec2 instance, Bastion should always be my IP address for security
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags = {
      Name = "Bastion SSH Access"
    } 
}
#3. App Security Group
resource "aws_security_group" "app-security-group" {
    name = "App Security Access"
    description = "This is gonna give my app access to HTTP/HTTPS via ALB and SSH via bastion"
    vpc_id = aws_vpc.vpc.id

    ingress {
        description = "HTTP Access"
        from_port = 80
        to_port =  80
        protocol = "tcp"
        security_groups = ["${aws_security_group.alb-security-group.id}"]
    }
    ingress {
        description = "HTTPS Access"
        from_port = 443
        to_port = 443
        protocol = "tcp"
        security_groups = ["${aws_security_group.alb-security-group.id}"]
    }
    ingress {
        description = "SSH Access"
        from_port = 22
        to_port = 22
        protocol = "tcp"
        security_groups = ["${aws_security_group.alb-security-group.id}"]
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }  
     tags = {
        Name = "App Security Group"
        }
}
#4. Database Security Group
resource "aws_security_group" "database-security-group" {
    name = "Database Security Access"
    description = "This is gonna give our Database access to the App"
    vpc_id = aws_vpc.vpc.id

    ingress {
        description = "Access our DB to port 3306 MYSQL/Aurora"
        from_port = 3306
        to_port = 3306
        protocol = "tcp"
        security_groups = ["${aws_security_group.app-security-group.id}"]
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags = {
      Name = "Database Security Group"
    }
  
}