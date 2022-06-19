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
      name       = "VPC MHS"
      author     = "MHS Grupo 1"
      version    = 1
      university = "ITBA"
      subject    = "Cloud Computing" 
  }
}

resource "aws_subnet" "this" {
  count = length(local.private_subnets)

  vpc_id = aws_vpc.this.id
  availability_zone = data.aws_availability_zones.this.names[count.index % local.total_az]
  cidr_block = local.private_subnets[count.index]

  tags = {
      name       = "Subnet MHS"
      author     = "MHS Grupo 1"
      version    = 1
      university = "ITBA"
      subject    = "Cloud Computing" 
  }
}
