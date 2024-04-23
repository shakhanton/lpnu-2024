output "lambda_courses_invoke_arn" {
  value = module.lambda_function_courses.lambda_function_invoke_arn
}

output "lambda_authors_invoke_arn" {
  value = module.lambda_function_authors.lambda_function_invoke_arn
}
output "lambda_courses_lambda_function_name" {
  value = module.lambda_function_courses.lambda_function_name
}

output "lambda_authors_lambda_function_name" {
  value = module.lambda_function_authors.lambda_function_name
}