# ---------------------------------------------------------------------------
# Amazon CloudWatch
# ---------------------------------------------------------------------------

resource "aws_sns_topic" "this" {
    name                = "apigw-alarm-topic"
}

resource "aws_cloudwatch_metric_alarm" "this" {
    alarm_name          = "apigw_alarm"
    comparison_operator = "GreaterThanThreshold"
    evaluation_periods  = "1"
    metric_name         = "Latency"
    namespace           = "AWS/ApiGateway"
    period              = "300"
    statistic           = "Average"
    threshold           = "10000.0"
    alarm_description   = "Monitoring API GW requests"
    alarm_actions       = [aws_sns_topic.this.arn]
    dimensions = {
        ApiName = var.service_to_monitor
        Stage = "production"
    }
}
