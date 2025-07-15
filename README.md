# Creating-a-VPC-using-terraform
Creating a VPC using Infrastructure as Code

## Tools Used 
### VPC
### Terraform 
## Create on terraform
- Create an AWS provider  
- Create a variable file to store the variables for flexibility
- Create a vpc terraform file 
  - Vpc 
  - Internet Gateway
  - 2 Public Subnets
  - 1 Route table
  - 4 Private subnets (2 App tier & 2 Database tier)
## Apply
```sh
terraform init
terraform fmt
terraform plan
terraform apply
terraform destroy
```
