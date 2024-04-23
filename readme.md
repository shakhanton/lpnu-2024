# Create S3 Terraform state bucket
```
aws s3api create-bucket --bucket 657694663228-terraform-tfstate-2024 --region eu-central-1 --create-bucket-configuration LocationConstraint=eu-central-1
```
```
aws s3api put-bucket-versioning --bucket 657694663228-terraform-tfstate-2024 --versioning-configuration Status=Enabled
```

# Create DynamoDB Terraform lock table

```terraform
aws dynamodb create-table --region eu-central-1 --table-name terraform-tfstate-lock-2024 --attribute-definitions AttributeName=LockID,AttributeType=S --key-schema AttributeName=LockID,KeyType=HASH --provisioned-throughput ReadCapacityUnits=1,WriteCapacityUnits=1
```