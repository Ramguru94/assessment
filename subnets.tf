data "aws_availability_zones" "available" {}

####### Label manuplation #######
module "label_subnets" {
  source     = "cloudposse/label/null"
  version    = "0.25.0"
  context    = module.base_label.context
  name       = "subnet"
  attributes = ["main"]
}

locals {
  vpc_cidr_bits  = split("/", var.vpc_cidr)[1]             # Extracting the number of bits from the VPC CIDR block
  subnet_bits    = var.subnet_mask_bits                    # Fixed subnet bits
  remaining_bits = local.subnet_bits - local.vpc_cidr_bits # Calculate remaining bits for subnetting
  subnet_cidr_map = {
    for name, cidr_block in module.subnets_cidr.network_cidr_blocks : name => cidr_block
  }
  selected_availability_zone = data.aws_availability_zones.available.names[0]
}

###### Subnet CIDR Calculation ######
module "subnets_cidr" {
  source  = "hashicorp/subnets/cidr"
  version = "1.0.0"

  base_cidr_block = var.vpc_cidr
  networks = [

    {
      name = "public"
      # TODO: new_bits Hardcoded as mentioed in the assessment
      new_bits = local.remaining_bits
    },
    {
      name = "private"
      # TODO: new_bits Hardcoded as mentioed in the assessment
      new_bits = local.remaining_bits
    },
  ]
}

###### Subnet Configuration ########
resource "aws_subnet" "demo" {
  for_each = module.subnets_cidr.network_cidr_blocks

  vpc_id            = aws_vpc.main.id
  availability_zone = local.selected_availability_zone
  cidr_block        = each.value
  tags              = merge(module.label_subnets.tags, { Name = "${each.key}_subnet" })
}


########## Public Subnet Configuration ##########
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
}

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.demo["public"].id
  route_table_id = aws_route_table.public.id
}


########## Private Subnet Configuration ##########
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id
  # Empty route table
}

resource "aws_route_table_association" "private" {
  subnet_id      = aws_subnet.demo["private"].id
  route_table_id = aws_route_table.private.id
}
