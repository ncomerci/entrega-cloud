resource "aws_rds_cluster" "this" {
  cluster_identifier = "mhs-cp-g1"
  engine             = "aurora-postgresql"
  engine_mode        = "provisioned"
  engine_version     = "13.6"
  database_name      = "mhs_users_db"
  master_username    = "mhs_users_db"
  master_password    = "mhs_users_db"

  #serverlessv2_scaling_configuration {
  #  max_capacity = 1.0
  #  min_capacity = 0.5
  #}
}

resource "aws_rds_cluster_instance" "this" {
  cluster_identifier = aws_rds_cluster.this.id
  instance_class     = "db.serverless"
  engine             = aws_rds_cluster.this.engine
  engine_version     = aws_rds_cluster.this.engine_version
}