#####################################
# deploy our lambda function
# Note : the lambda src is the official AWS source
# we only add the elasticSearh domain in environment variable
# to be more generic.
#####################################
module "lambda" {
  source  = "terraform-aws-modules/lambda/aws"
  version = "2.34.0"

  # set global attributs
  function_name = format("lbd-%s-%s", var.environment, var.function_name)
  description   = "Stream RDS Logs on ElasticSearch"
  publish       = true
  handler       = "index.handler"
  source_path = [
    "${path.module}/lambda-src/index.js",
  ]

  memory_size = "128"
  runtime     = "nodejs12.x"
  timeout     = 900

  # attach a cloudWatch log group
  create_role = false
  lambda_role = var.lambda_role_arn

  # add environment variables
  environment_variables = {
    ELASTICSEARCH_ENDPOINT = var.es_domain_endpoint
  }

  # put tags on lambda function
  tags = var.tags
}

##############################
# Allow CloudWatch Logs to invoke Lambda function
##############################
data "aws_cloudwatch_log_group" "rds_logs" {
  name = var.rds_cloudwatch_log_name
}

resource "aws_lambda_permission" "cloudwatch-logs-invoke-elasticsearch-lambda" {
  statement_id   = format("rp-%s-%s-logs-to-es", var.environment, var.rds_name)
  action         = "lambda:InvokeFunction"
  function_name  = module.lambda.lambda_function_arn
  principal      = "logs.${var.region}.amazonaws.com"
  source_arn     = format("%s:*", data.aws_cloudwatch_log_group.rds_logs.arn)
  source_account = var.source_account_id
}


###########################################
# Deploy a subscription filter on RDS Cloudwatch Logs
###########################################
resource "aws_cloudwatch_log_subscription_filter" "rds_cw_subscription" {
  name            = format("subsr-%s-%s-logs", var.environment, var.rds_name)
  log_group_name  = var.rds_cloudwatch_log_name
  filter_pattern  = "[date, time, misc, message]"
  destination_arn = module.lambda.lambda_function_arn
}
