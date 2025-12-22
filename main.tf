provider "aws" {
  region = var.aws_region
}

locals {
  cloud_facts = {
    "1"  = "AWS S3 was one of the very first AWS services, launched in 2006."
    "2"  = "Netflix runs almost all of its infrastructure on AWS."
    "3"  = "Cloud computing can save companies up to 30% on IT costs."
    "4"  = "NASA uses AWS to store and share Mars mission data with the public."
    "5"  = "AWS has more than 200 fully featured services today."
    "6"  = "The 'cloud' doesn’t float in the sky, it’s made of giant data centers on Earth."
    "7"  = "More than 90% of Fortune 100 companies use AWS."
    "8"  = "AWS data centers are so secure that they require retina scans and 24/7 guards."
    "9"  = "Serverless doesn’t mean there are no servers, it just means you don’t manage them."
    "10" = "Each AWS Availability Zone has at least one independent power source and cooling system."
    "11" = "Amazon once accidentally took down parts of the internet when S3 had an outage in 2017."
    "12" = "The fastest-growing AWS service is Amazon SageMaker, used for Machine Learning."
    "13" = "The word 'cloud' became popular in the 1990s as a metaphor for the internet."
    "14" = "AWS Lambda can automatically scale from zero to thousands of requests per second."
    "15" = "More data is stored in the cloud today than in all personal computers combined."
  }
}

data "archive_file" "lambda_zip" {
  type        = "zip"
  source_file = "${path.module}/lambda/lambda_function.py"
  output_path = "${path.module}/lambda/lambda_function.zip"
}

resource "aws_iam_role" "lambda_role" {
  name = "cloud-fun-facts-lambda-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect    = "Allow"
      Principal = { Service = "lambda.amazonaws.com" }
      Action    = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_basic_logs" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_lambda_function" "cloud_fun_facts" {
  function_name = var.lambda_function_name
  runtime       = "python3.13"
  handler       = "lambda_function.lambda_handler"
  role          = aws_iam_role.lambda_role.arn

  filename         = data.archive_file.lambda_zip.output_path
  source_code_hash = data.archive_file.lambda_zip.output_base64sha256
}

resource "aws_apigatewayv2_api" "funfacts_api" {
  name          = "FunfactsAPI"
  protocol_type = "HTTP"
}

resource "aws_apigatewayv2_integration" "lambda_integration" {
  api_id             = aws_apigatewayv2_api.funfacts_api.id
  integration_type   = "AWS_PROXY"
  integration_uri    = aws_lambda_function.cloud_fun_facts.invoke_arn
  integration_method = "POST"
}

resource "aws_apigatewayv2_route" "funfact_route" {
  api_id    = aws_apigatewayv2_api.funfacts_api.id
  route_key = "GET /funfact"
  target    = "integrations/${aws_apigatewayv2_integration.lambda_integration.id}"
}

resource "aws_apigatewayv2_stage" "default" {
  api_id      = aws_apigatewayv2_api.funfacts_api.id
  name        = "$default"
  auto_deploy = true
}

resource "aws_lambda_permission" "api_gateway" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.cloud_fun_facts.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_apigatewayv2_api.funfacts_api.execution_arn}/*/*"
}

resource "aws_dynamodb_table" "cloud_facts" {
  name         = "CloudFacts"
  billing_mode = "PAY_PER_REQUEST"

  hash_key = "FactID"

  attribute {
    name = "FactID"
    type = "S"
  }

  tags = {
    Name        = "CloudFacts"
    Environment = "dev"
  }
}

resource "aws_dynamodb_table_item" "cloud_facts" {
  for_each = local.cloud_facts

  table_name = aws_dynamodb_table.cloud_facts.name
  hash_key   = aws_dynamodb_table.cloud_facts.hash_key

  item = jsonencode({
    FactID   = { S = each.key }
    FactText = { S = each.value }
  })
}

resource "aws_iam_role_policy_attachment" "lambda_dynamodb_read" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonDynamoDBReadOnlyAccess"
}
