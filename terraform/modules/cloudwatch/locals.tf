locals {
  topic_name = "apigw-alarm-topic"

  apigw_alarm = {
    name                = "apigw_alarm"
    description         = "Monitoring API GW requests"
    comparison_operator = "GreaterThanThreshold"
    evaluation_periods  = "1"
    metric_name         = "Latency"
    namespace           = "AWS/ApiGateway"
    period              = "300"
    statistic           = "Average"
    threshold           = "10000.0"
  }

  tags = {
    name = "ClouWatch Alarm MHS"
  }
}