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


# TODO(para el final): Lambdas en VPC, accederian a S3 y DynamoDB por VPC endpoint 
resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id

}

resource "aws_vpc_endpoint" "s3" {
  vpc_id       = aws_vpc.this.id
  service_name = "com.amazonaws.us-east-1.s3"
}
