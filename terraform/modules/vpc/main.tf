# ---------------------------------------------------------------------------
# Amazon VPC
# ---------------------------------------------------------------------------

data "aws_availability_zones" "this" {
  state = "available"
  filter { ## Only AZs
    name   = "opt-in-status"
    values = ["opt-in-not-required"]
  }

}

resource "aws_vpc" "this" {
  cidr_block = var.vpc_cidr

  tags = {
    name = local.aws_vpc.tags.name
  }
}

resource "aws_subnet" "this" {
  count = length(local.private_subnets)

  vpc_id            = aws_vpc.this.id
  availability_zone = data.aws_availability_zones.this.names[count.index % local.total_az]
  cidr_block        = local.private_subnets[count.index]

  tags = {
    name = local.aws_subnet.tags.name
  }
}

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id
}

resource "aws_vpc_endpoint" "this" {
  for_each = var.vpc_endpoints

  vpc_id            = aws_vpc.this.id
  service_name      = each.value.service_name
  vpc_endpoint_type = "Gateway"
  route_table_ids   = [aws_vpc.this.default_route_table_id]
}
