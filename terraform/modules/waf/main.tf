# --------------------------------------------------------------------
# Amazon WAF resources
# --------------------------------------------------------------------

resource "aws_wafv2_web_acl" "this" {
  name        = "wacl-cloudfront"
  description = "Contains rules that are generally applicable to web applications. This provides protection against exploitation of a wide range of vulnerabilities, including those described in OWASP publications."
  scope       = "CLOUDFRONT"

  default_action {
    allow {}
  }

  rule {
    name     = "owasp-rule"
    priority = 1

    action {
      block {}
    }

    statement {
      managed_rule_group_statement {
        vendor_name = "AWS"
        name        = "AWSManagedRulesCommonRuleSet"
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = false
      metric_name                = "owasp-rule-metrics"
      sampled_requests_enabled   = false
    }
  }

  #TODO: tags
  tags = {
    Tag1 = "Value1"
    Tag2 = "Value2"
  }

  visibility_config {
    cloudwatch_metrics_enabled = false
    metric_name                = "friendly-metric-name"
    sampled_requests_enabled   = false
  }
}