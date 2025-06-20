resource "aws_cloudwatch_metric_alarm" "frontend_replica_count" {
  alarm_name          = "${local.name_prefix}-frontend-replica-count"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = 1
  metric_name         = "service_number_of_running_pods"
  namespace           = "ContainerInsights"
  period              = 60
  statistic           = "Average"
  threshold           = 1
  alarm_description   = "default namespaceのfrontendサービスのPod数が1未満になったらアラート"
  actions_enabled     = false
  treat_missing_data  = "breaching"

  dimensions = {
    ClusterName = local.name_prefix
    Namespace   = "default"
    Service     = "frontend"
  }
}

resource "aws_cloudwatch_log_metric_filter" "log_test_metric" {
  name           = "${local.name_prefix}-log-test-metric"
  log_group_name = "/aws/containerinsights/${local.name_prefix}/application"
  pattern        = "%log-test%"

  metric_transformation {
    name      = "LogTestMatchCount"
    namespace = "Custom/LogMonitor"
    value     = "1"
  }
}

resource "aws_cloudwatch_metric_alarm" "log_test_alarm" {
  alarm_name          = "${local.name_prefix}-log-test-alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 1
  metric_name         = aws_cloudwatch_log_metric_filter.log_test_metric.metric_transformation[0].name
  namespace           = aws_cloudwatch_log_metric_filter.log_test_metric.metric_transformation[0].namespace
  period              = 60
  statistic           = "Sum"
  threshold           = 1
  alarm_description   = "log-testという文字列がログに出現したらアラート"
  actions_enabled     = false // 通知したい場合はSNS等のアクションを追加
  treat_missing_data  = "notBreaching"
}
