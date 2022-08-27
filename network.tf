module "vpc1" {
  source         = "terraform-aws-modules/vpc/aws"
  version        = "3.14.2"
  name           = "${var.system_name}-${var.env}-vpc"
  cidr           = "10.0.0.0/16"
  azs            = ["${local.region}a", "${local.region}c"]
  public_subnets = ["10.0.0.0/24"]
  tags           = local.tags
}

module "vpc2" {
  source          = "terraform-aws-modules/vpc/aws"
  version         = "3.14.2"
  name            = "${var.system_name}-${var.env}-vpc2"
  cidr            = "172.16.0.0/16"
  azs             = ["${local.region}a", "${local.region}c"]
  private_subnets = ["172.16.1.0/24"]
  tags            = local.tags
}

resource "aws_vpc_peering_connection" "this" {
  peer_vpc_id = module.vpc1.vpc_id
  vpc_id      = module.vpc2.vpc_id
  auto_accept = true
}

resource "aws_route" "r1" {
  route_table_id            = module.vpc1.public_route_table_ids[0]
  destination_cidr_block    = module.vpc2.vpc_cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.this.id
}

resource "aws_route" "r2" {
  route_table_id            = module.vpc2.private_route_table_ids[0]
  destination_cidr_block    = module.vpc1.vpc_cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.this.id
}
