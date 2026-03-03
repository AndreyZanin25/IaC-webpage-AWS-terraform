Scenario:
You are tasked with provisioning a basic web application stack in AWS using Terraform.
Requirements:
1) Deploy an EC2 instance running an Nginx server.
2) Use a security group to allow:
   HTTP (port 80)
   SSH (port 22)
3) The Nginx server should display a custom webpage with the text: “Deployed via Terraform”
4) Use variables to make the configuration reusable for different environments (e.g., dev, prod)
```
IaC-webpage-AWS-terraform/
│
├── modules/
│   └── ec2/
│       ├── main.tf
│       ├── variables.tf
│       └── outputs.tf
│
├── environments/
│   ├── dev/
│   │   └── terraform.tfvars
│   └── prod/
│       └── terraform.tfvars
│
├── main.tf
├── variables.tf
├── outputs.tf
├── versions.tf
└── README.md
```
