resource "aws_sns_topic" "drift_notification" {
  name = "${local.name_prefix}-drift-notification"
}

resource "aws_sns_topic_subscription" "drift_notification_email" {
  topic_arn = aws_sns_topic.drift_notification.arn
  protocol  = "email"
  endpoint  = local.notification_email
}

output "sns_topic_arn" {
  description = "ARN of the SNS topic for drift notifications"
  value       = aws_sns_topic.drift_notification.arn
}