output "lambda_name" {
  value = [for k in var.lambda_detail : k]
}