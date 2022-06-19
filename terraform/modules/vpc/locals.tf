locals {
  private_subnets = [cidrsubnet(aws_vpc.this.cidr_block, 8, 0), cidrsubnet(aws_vpc.this.cidr_block, 8, 1)]
  total_az = length(data.aws_availability_zones.this.names)
}