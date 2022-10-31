# iam_name_for_lambda = ["z-test-lambda-role5", "z-test-lambda-role4"]
# lambda_logging_policy_name = "z-test-policy-lambda-0010"
filename = "lambda_function_payload.py"
# lambda_function_name = ["z-test-assignment", "z-test-assignment2"]
runtime           = "python3.7"
handler           = "lambda_function.lambda_handler"
owner             = "pinkesh"
env               = "Test"
retention_in_days = 14

lambda_detail = {
  z-test-assignment1 = {
    role   = "z-test-lambda-role1",
    policy = "z-test-policy-lambda-001"
  },
  z-test-assignment1 = {
    role   = "z-test-lambda-role2",
    policy = "z-test-policy-lambda-002"
  }
}