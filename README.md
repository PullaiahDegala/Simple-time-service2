# Infrastructure Setup

## Prerequisites

- AWS account with IAM permissions to create VPC, ECS, ALB, etc.
- Terraform installed on your machine.
- AWS CLI configured with credentials.

## Instructions

1. Clone the repository.
2. Set up AWS credentials using AWS CLI (`aws configure`).
3. Navigate to the `terraform/` directory.
4. Run `terraform init` to initialize Terraform.
5. Run `terraform plan` to preview the infrastructure changes.
6. Run `terraform apply` to apply the configuration and create the resources.
7. Access the application using the Load Balancer URL.

## Notes

Ensure you have Docker and the app files inside the `app/` folder. Modify the ECS task definition if using a different image.
# Simple-time-service2
