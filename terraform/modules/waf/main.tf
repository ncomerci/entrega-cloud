# --------------------------------------------------------------------
# Amazon WAF  
# --------------------------------------------------------------------

module "global_settings" {
  source = "../global"
}

resource "aws_wafv2_web_acl" "this" {
  name        = "mhs-wacl-cloudfront"
  description = "Contains rules that are generally applicable to web applications. This provides protection against exploitation of a wide range of vulnerabilities, including those described in OWASP publications."
  scope       = "CLOUDFRONT"

  default_action {
    allow {}
  }

  rule {
    name     = "AWSManagedRulesCommonRuleSet"
    priority = 1

    override_action {
      count {}
    }

    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesCommonRuleSet"
        vendor_name = "AWS"

        excluded_rule {
          name = "SizeRestrictions_QUERYSTRING"
        }

        excluded_rule {
          name = "NoUserAgent_HEADER"
        }

        scope_down_statement {
          geo_match_statement {
            country_codes = ["US", "NL"]
          }
        }
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = false
      metric_name                = "owasp-rule-metric"
      sampled_requests_enabled   = false
    }
  }

  tags = {
    name = local.tags.name
  }

  visibility_config {
    cloudwatch_metrics_enabled = false
    metric_name                = "owasp-metric"
    sampled_requests_enabled   = false
  }
}