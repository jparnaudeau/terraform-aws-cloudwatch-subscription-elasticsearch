# terraform-aws-cloudwatch-subscription-elasticsearch

This module is responsible to subscribe a cloudwatch logs to an ElasticSearch domain. It have been designed for a specific need, regarding the indexation of rds logs. **This module is not generic**. 

This module will : 

* deploy a lambda function with the AWS official code that ready to stream a cloudwatch logs. The uniq update is to pass the elasticsearch domain endpoint in environment variable of the lambda instead "hardcoded" value as it's done when you create the subscription filter from the console.
* deploy the subscription filter on the cloudwatch log group to the lambda.
* Think about to allow, in the elasticsearch domain policy, the role of the lambda.

Refer to this [example](https://github.com/jparnaudeau/terraform-postgresql-database-admin/tree/master/examples/full-rds-example) to see the initial use of this module. Create Issue on my github if you want that i push a more generic module.

## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_lambda"></a> [lambda](#module\_lambda) | terraform-aws-modules/lambda/aws | 2.34.0 |

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_log_subscription_filter.rds_cw_subscription](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_subscription_filter) | resource |
| [aws_lambda_permission.cloudwatch-logs-invoke-elasticsearch-lambda](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_permission) | resource |
| [aws_cloudwatch_log_group.rds_logs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/cloudwatch_log_group) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_environment"></a> [environment](#input\_environment) | The Environment label | `string` | `"test"` | no |
| <a name="input_es_domain_endpoint"></a> [es\_domain\_endpoint](#input\_es\_domain\_endpoint) | The ElasticSearch Domain endpoint | `string` | n/a | yes |
| <a name="input_function_name"></a> [function\_name](#input\_function\_name) | The lambda function name. Format lbd-{environment}-{function\_name} | `string` | `"stream-logs"` | no |
| <a name="input_lambda_role_arn"></a> [lambda\_role\_arn](#input\_lambda\_role\_arn) | The Lambda Role ARN | `string` | n/a | yes |
| <a name="input_rds_cloudwatch_log_name"></a> [rds\_cloudwatch\_log\_name](#input\_rds\_cloudwatch\_log\_name) | The Name of the Cloudwatch Log for RDS Instance for which we want stream logs | `string` | n/a | yes |
| <a name="input_rds_name"></a> [rds\_name](#input\_rds\_name) | The RDS Identifier for which we want stream logs | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | The AWS Region | `string` | `"eu-west-3"` | no |
| <a name="input_source_account_id"></a> [source\_account\_id](#input\_source\_account\_id) | The AWS Source Account Id | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_lambda_function_arn"></a> [lambda\_function\_arn](#output\_lambda\_function\_arn) | The ARN of the Lambda Function |
| <a name="output_lambda_function_invoke_arn"></a> [lambda\_function\_invoke\_arn](#output\_lambda\_function\_invoke\_arn) | The Invoke ARN of the Lambda Function |
| <a name="output_lambda_function_last_modified"></a> [lambda\_function\_last\_modified](#output\_lambda\_function\_last\_modified) | The date Lambda Function resource was last modified |
| <a name="output_lambda_function_name"></a> [lambda\_function\_name](#output\_lambda\_function\_name) | The name of the Lambda Function |
| <a name="output_lambda_function_qualified_arn"></a> [lambda\_function\_qualified\_arn](#output\_lambda\_function\_qualified\_arn) | The ARN identifying your Lambda Function Version |
| <a name="output_lambda_function_version"></a> [lambda\_function\_version](#output\_lambda\_function\_version) | Latest published version of Lambda Function |
| <a name="output_streamed_cloudwatch_log_arn"></a> [streamed\_cloudwatch\_log\_arn](#output\_streamed\_cloudwatch\_log\_arn) | The CloudWatch Log name that it streamed by the Lambda Function |
| <a name="output_streamed_cloudwatch_log_name"></a> [streamed\_cloudwatch\_log\_name](#output\_streamed\_cloudwatch\_log\_name) | The CloudWatch Log name that it streamed by the Lambda Function |
