################################################
#  Outputs for lambda
################################################
output "lambda_function_arn" {
  description = "The ARN of the Lambda Function"
  value       = module.lambda.lambda_function_arn
}

output "lambda_function_invoke_arn" {
  description = "The Invoke ARN of the Lambda Function"
  value       = module.lambda.lambda_function_invoke_arn
}

output "lambda_function_name" {
  description = "The name of the Lambda Function"
  value       = module.lambda.lambda_function_name
}

output "lambda_function_qualified_arn" {
  description = "The ARN identifying your Lambda Function Version"
  value       = module.lambda.lambda_function_qualified_arn
}

output "lambda_function_version" {
  description = "Latest published version of Lambda Function"
  value       = module.lambda.lambda_function_version
}

output "lambda_function_last_modified" {
  description = "The date Lambda Function resource was last modified"
  value       = module.lambda.lambda_function_last_modified
}

################################################
#  Outputs for CloudWatch Logs 
################################################
output "streamed_cloudwatch_log_name" {
  description = "The CloudWatch Log name that it streamed by the Lambda Function"
  value       = data.aws_cloudwatch_log_group.rds_logs.name
}

output "streamed_cloudwatch_log_arn" {
  description = "The CloudWatch Log name that it streamed by the Lambda Function"
  value       = data.aws_cloudwatch_log_group.rds_logs.arn
}
