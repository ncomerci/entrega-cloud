# --------------------------------------------------------------------
# Amazon VPC output
# --------------------------------------------------------------------

output "subnet_ids" {
  description = "The list of subnets created"
  value       = [for subnet in aws_subnet.this : subnet.id]
}

output "vpc_id" {
  description = "The VPC id"
  value       = aws_vpc.this.id
}