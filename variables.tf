#######################################
# Global Variables
#######################################
variable "region" {
  type        = string
  description = "The AWS Region"
  default     = "eu-west-3"
}

variable "environment" {
  type        = string
  description = "The Environment label"
  default     = "test"
}

variable "tags" {
  type        = map(string)
  description = "A map of tags"
  default     = {}
}

#######################################
# Variables for lambda deployment
#######################################
variable "function_name" {
  type        = string
  description = "The lambda function name. Format lbd-{environment}-{function_name}"
  default     = "stream-logs"
}

variable "lambda_role_arn" {
  type        = string
  description = "The Lambda Role ARN"
}

variable "rds_name" {
  type        = string
  description = "The RDS Identifier for which we want stream logs"
}

variable "rds_cloudwatch_log_name" {
  type        = string
  description = "The Name of the Cloudwatch Log for RDS Instance for which we want stream logs"
}

variable "es_domain_endpoint" {
  type        = string
  description = "The ElasticSearch Domain endpoint"
}

variable "source_account_id" {
  type        = string
  description = "The AWS Source Account Id"
}
