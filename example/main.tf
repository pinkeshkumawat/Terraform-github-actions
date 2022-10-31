data "archive_file" "lambda_file" {
  type        = "zip"
  source_file = "${path.module}/lambda_payload/${var.filename}"
  output_path = "${path.module}/lambda_payload/${var.filename}.zip"
}

module "lambda" {
  source                     = "../"
  for_each                   = var.lambda_detail
  iam_name_for_lambda        = each.value.role
  lambda_logging_policy_name = each.value.policy
  filename                   = try(data.archive_file.lambda_file.output_path, null)
  lambda_function_name       = each.key
  handler                    = var.handler
  runtime                    = var.runtime
  owner                      = var.owner
  env                        = var.env
  retention_in_days          = var.retention_in_days
}

