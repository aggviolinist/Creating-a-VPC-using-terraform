# Creating-a-VPC-using-terraform
Creating a VPC using Infrastructure as Code
![Alt text](/images/vpcpic.jpg?raw=true "The difference between Private and Public Subnets")
![Alt text](/images/vpc-architecture.jpg?raw=true "The architectural design of the VPC")


## Tools Used 
### VPC
### Terraform 
## Create on terraform
- Create an AWS provider  
- Create a variable file to store the variables for flexibility
- Create a vpc terraform file 
  - Vpc 
  - Internet Gateway
  - 1 Route table
  - 2 Public Subnets
  - Associate the Public Route tables to the the Public Subnets
  - 4 Private subnets (2 App tier & 2 Database tier)
## Apply
```sh
terraform init
terraform fmt
terraform plan
terraform apply
terraform destroy
```
# Creating a NAT Gateway using terraform
- Create 2 elastic ips for the public subnets
- Create 2 NAT gateways
   - Connect the NAT gateway to the public subnets using `subnet_id`
   - Connect the NAT gateway to the EIP using `allocation_id`
- Create 2 Private Route Tables
- Associate the private subnets to the Private Route tables 

# Creating a Security Group using terraform
- Create the ALB security group
  - It's gonna route traffic from port `80,443`
- Create the Bastion security group
  - The Ip of the bastion should always be an individual IP and not open to the internet 
  - Uses port `22`
- Create app security group, it accepts traffic from;
  - 444 `HTTPS`
  - 80 `HTTP`
  - 22 `SSH`
- Database security group, it accepts traffic from;
  - 3306 `Mysql/Aurora traffic`



