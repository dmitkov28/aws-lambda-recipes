## Overview
A simple Dockerized Python app using a non-AWS base image.
Includes:
- AWS Lambda 
- ECR Repo + Docker Image
- Cloudwatch Logs for the Lambda

## Code
Write your code in  [app/](./app/)
Adjust the base image as needed in the [Dockerfile](./Dockerfile)

## Provision the infrastructure with Terraform
```
cd terraform
terraform init
terraform apply
```

Override the default variable values with
```
terraform apply -var="function_name=my_custom_function" -var="ecr_repo_name=my_custom_repo"
```

Alternatively, use a `.tfvars` file:

`custom.tfvars`
```
function_name = "my_custom_function"
ecr_repo_name = "my_custom_repo"
```

Spin up with:

```
terraform apply -var-file="custom.tfvars"
```

Tear down with:

```
terraform destroy
```