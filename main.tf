resource "aws_iam_role" "iam_for_lambda" {
  name = var.iam_name_for_lambda

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_policy" "lambda_logging_policy" {
  name        = var.lambda_logging_policy_name
  path        = "/"
  description = "IAM policy for logging from a lambda"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Resource": "arn:aws:logs:*:*:*",
      "Effect": "Allow"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "lambda_policy_attachment" {
  role       = aws_iam_role.iam_for_lambda.name
  policy_arn = aws_iam_policy.lambda_logging_policy.arn
}

resource "aws_cloudwatch_log_group" "cloudwatch_log" {
  name              = var.lambda_function_name
  retention_in_days = var.retention_in_days 
}

resource "aws_lambda_function" "Lambda_func" {
  # If the file is not in the current working directory you will need to include a 
  # path.module in the filename.
  filename      = var.filename //"lambda_function_payload.zip"
  function_name = var.lambda_function_name
  role          = aws_iam_role.iam_for_lambda.arn // ask how to import it

  # The filebase64sha256() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the base64sha256() function and the file() function:
  # source_code_hash = "${base64sha256(file("lambda_function_payload.zip"))}"
  source_code_hash = filebase64sha256(var.filename)
  handler       = var.handler

  runtime = var.runtime //"python3.7"

  environment {
    variables = {
      owner = var.owner
      environment = var.env
    }
  }

  # ... other configuration ...
  depends_on = [
    aws_iam_role_policy_attachment.lambda_policy_attachment,  //chk for import 
    aws_cloudwatch_log_group.cloudwatch_log,
  ]
}
