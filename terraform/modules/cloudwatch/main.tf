# ---------------------------------------------------------------------------
# Amazon CloudWatch
# ---------------------------------------------------------------------------

module "global_settings" {
  source = "../global"
}

resource "aws_sns_topic" "this" {
  name = local.topic_name
}

resource "aws_cloudwatch_metric_alarm" "this" {
  alarm_name          = local.apigw_alarm.name
  alarm_description   = local.apigw_alarm.description
  comparison_operator = local.apigw_alarm.comparison_operator
  evaluation_periods  = local.apigw_alarm.evaluation_periods
  metric_name         = local.apigw_alarm.metric_name
  namespace           = local.apigw_alarm.namespace
  period              = local.apigw_alarm.period
  statistic           = local.apigw_alarm.statistic
  threshold           = local.apigw_alarm.threshold
  alarm_actions       = [aws_sns_topic.this.arn]

  dimensions = {
    ApiName = var.service_to_monitor
    Stage   = module.global_settings.stage_name
  }

  tags = {
    name = local.tags.name
  }
}
