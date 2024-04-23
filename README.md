# Terraform Configuration for VPC and Subnets

This Terraform configuration sets up a Virtual Private Cloud (VPC) in AWS along with public and private subnets within the VPC. It also configures routing tables for both public and private subnets, allowing or restricting access to the internet as specified.

## Table of Contents

- [Prerequisites](#prerequisites)
- [Usage](#usage)
- [Variables](#variables)
- [Modules](#modules)
- [Resources](#resources)
- [License](#license)

## Prerequisites

Before using this Terraform configuration, make sure you have the following:

- An AWS account with appropriate permissions to create VPCs, subnets, and associated resources.
- Terraform installed on your local machine.
- AWS credentials configured either through environment variables, AWS CLI configuration, or IAM instance profiles.

## Usage

1. Clone this repository to your local machine:

   ```bash
   git clone https://github.com/Ramguru94/assessment.git
   ```

2. Change into the directory containing the Terraform configuration:
  ```bash
  cd assessment
  ```
3. Initialize Terraform:
  ```bash
  terraform init
  ```
4. Modify the terraform.tfvars file to customize the configuration if necessary:
```hcl
aws_region      = "us-west-2"
aws_access_key  = "YOUR_AWS_ACCESS_KEY"
aws_secret_key  = "YOUR_AWS_SECRET_KEY"
vpc_cidr        = "192.170.0.0/20"
subnet_mask_bits= 24
environment     = "test"
```
5. Review the Terraform plan:
```bash
terraform plan
```
6. Apply the Terraform configuration to create the infrastructure:
```bash
terraform apply
```
7. After you're done, you can destroy the infrastructure:
```bash
terraform destroy
```

## Variables

- `aws_region`: The AWS region where the infrastructure will be deployed.
- `aws_access_key`: AWS Access Key ID for the target AWS account.
- `aws_secret_key`: AWS Secret Key for the target AWS account.
- `vpc_cidr`: The IPv4 CIDR block to use for the VPC.
- `subnet_mask_bits`: The number of bits to allocate for the CIDR block of the subnets.
- `environment`: The environment for the resources (default: "test").

## Modules

- `base_label`: Cloud Posse null label module for tagging resources.
- `subnets_cidr`: HashiCorp subnets CIDR module for dynamically calculating subnet CIDR blocks.
- `label_vpc`: Cloud Posse null label module for tagging the VPC.

## Resources

- `aws_vpc`: AWS VPC resource for creating the Virtual Private Cloud.
- `aws_subnet`: AWS Subnet resource for creating subnets within the VPC.
- `aws_internet_gateway`: AWS Internet Gateway resource for providing internet access to the VPC.
- `aws_route_table`: AWS Route Table resource for configuring routing within the VPC.
- `aws_route_table_association`: AWS Route Table Association resource for associating subnets with route tables.

## Terraform Provider Lock

Terraform provider lock ensures that the Terraform configuration is always applied with a specific provider version. This prevents unexpected changes or behavior caused by provider updates. To implement provider lock, you can use Terraform's built-in mechanisms or third-party tools such as `terraform-provider-lock`.


## License

This Terraform configuration is provided under the [MIT License](LICENSE).

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.46 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.46.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_base_label"></a> [base\_label](#module\_base\_label) | cloudposse/label/null | 0.25.0 |
| <a name="module_label_subnets"></a> [label\_subnets](#module\_label\_subnets) | cloudposse/label/null | 0.25.0 |
| <a name="module_label_vpc"></a> [label\_vpc](#module\_label\_vpc) | cloudposse/label/null | 0.25.0 |
| <a name="module_subnets_cidr"></a> [subnets\_cidr](#module\_subnets\_cidr) | hashicorp/subnets/cidr | 1.0.0 |

## Resources

| Name | Type |
|------|------|
| [aws_internet_gateway.gw](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway) | resource |
| [aws_route_table.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table_association.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_route_table_association.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_subnet.demo](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_vpc.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) | resource |
| [aws_availability_zones.available](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_access_key"></a> [aws\_access\_key](#input\_aws\_access\_key) | AWS Access Key ID for the target AWS account | `string` | n/a | yes |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS region to use | `string` | `"us-west-2"` | no |
| <a name="input_aws_secret_key"></a> [aws\_secret\_key](#input\_aws\_secret\_key) | AWS Secret Key for the target AWS account | `string` | n/a | yes |
| <a name="input_aws_session_token"></a> [aws\_session\_token](#input\_aws\_session\_token) | AWS Session Token for the target AWS account. Required only if authenticating using temporary credentials | `string` | `""` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | The environment for the resources | `string` | `"test"` | no |
| <a name="input_subnet_mask_bits"></a> [subnet\_mask\_bits](#input\_subnet\_mask\_bits) | The number of bits to allocate for the CIDR block of the subnets | `number` | `24` | no |
| <a name="input_vpc_cidr"></a> [vpc\_cidr](#input\_vpc\_cidr) | The IPv4 CIDR block to use for the VPC | `string` | `"192.170.0.0/20"` | no |
