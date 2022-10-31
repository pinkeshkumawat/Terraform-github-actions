variable "iam_name_for_lambda" {
  type = string
  description = "Add lambda function IAM Role name"
}

variable "lambda_logging_policy_name" {
  type = string
  description = "Add lambda logging policy name"
}

variable "filename" {
  type = string
  description = "(Required) Add lambda function payload filename"
}

variable "lambda_function_name" {
  type = string
  description = "(Required) Add lambda function name"
}

variable "runtime" {
  type = string
  description = "(Required) Add lambda function runtime"
}

variable "handler" {
  type = string
  description = "(Required) Add lambda function handler "
}

variable "owner" {
  type = string
  description = "(Required) Add lambda function Env variable owner "
}

variable "env" {
  type = string
  description = "(Required) Add lambda function Env variable environment/ test/dev"
}

variable "retention_in_days" {
  type = number
  description = "(Required) Add lambda function retention_in_days"
}
