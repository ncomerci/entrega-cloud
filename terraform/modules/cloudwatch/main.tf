resource "aws_cloudwatch_metric_alarm" "apigwalarm" {
    alarm_name          = "apigwalarm"
    comparison_operator = "GreaterThanThreshold"
    evaluation_periods  = "1"
    metric_name         = "Latency"
    namespace           = "AWS/ApiGateway"
    period              = "300"
    statistic           = "Average"
    threshold           = "10000.0"
    alarm_description   = ""
    alarm_actions       = ["arn:aws:sns:us-east-1:865913489650:epineiro@itba.edu.ar"]
    dimensions {
        ApiName = var.service_to_monitor
        Stage = "production"
    }
}
