provider "aws" {
  region = var.aws_region
}

// Use Terraform archive_file
data "archive_file" "lambda_zip" {
  type        = "zip"
  source_file = "lambda/handler.py"
  output_path = "lambda/function.zip"
}

// Create S3 Buckets (Input & Output)
resource "aws_s3_bucket" "input_bucket" {
  bucket        = "polly-input-bucket-${random_id.suffix.hex}"
  force_destroy = true # demo purpose
  tags          = var.tags
}

resource "aws_s3_bucket" "output_bucket" {
  bucket        = "polly-output-bucket-${random_id.suffix.hex}"
  force_destroy = true # demo purpose
  tags          = var.tags
}

resource "random_id" "suffix" {
  byte_length = 4
}
//////////////////////////////////////////////////////////////////////////////////////////////////////

// IAM Role for Lambda (Critical)
resource "aws_iam_role" "lambda_role" {
  name = "polly-lambda-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "lambda.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })
}

// IAM Policy
data "aws_caller_identity" "current" {}

resource "aws_iam_policy" "lambda_policy" {
  name = "polly-lambda-policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      // GetObject from input bucket (no encryption required)
      {
        Effect = "Allow"
        Action = [
          "s3:GetObject"
        ]
        Resource = [
          "${aws_s3_bucket.input_bucket.arn}/*"
        ]
      },
      // PutObject to output bucket (encryption required)
      {
        Effect = "Allow"
        Action = [
          "s3:PutObject"
        ]
        Resource = [
          "${aws_s3_bucket.output_bucket.arn}/*"
        ]
        Condition = {
          StringEquals = {
            "s3:x-amz-server-side-encryption" : "AES256"
          }
        }
      },
      // Polly Permission
      {
        Effect   = "Allow"
        Action   = "polly:SynthesizeSpeech"
        Resource = "*"
      },
      // Cloudwatch Logs Permission
      {
        Effect = "Allow"
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Resource = "arn:aws:logs:${var.aws_region}:${data.aws_caller_identity.current.account_id}:log-group:/aws/lambda/${aws_lambda_function.polly_lambda.function_name}:*"
      }
    ]
  })

  tags = var.tags
}

// Attach Policy
resource "aws_iam_role_policy_attachment" "attach" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = aws_iam_policy.lambda_policy.arn
}

// Lambda Deployment via Terraform
resource "aws_lambda_function" "polly_lambda" {
  function_name = "polly-text-to-speech"

  runtime     = "python3.11"
  handler     = "handler.lambda_handler"
  role        = aws_iam_role.lambda_role.arn
  timeout     = 10  # Lambda Timeout Explicitly Set
  memory_size = 256 # Lambda Memory Explicitly Set

  filename         = data.archive_file.lambda_zip.output_path
  source_code_hash = data.archive_file.lambda_zip.output_base64sha256

  environment {
    variables = {
      OUTPUT_BUCKET = aws_s3_bucket.output_bucket.bucket
    }
  }

  tags = var.tags
}

// Permission for S3 to invoke Lambda
resource "aws_lambda_permission" "s3_permission" {
  statement_id  = "AllowS3Invoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.polly_lambda.function_name
  principal     = "s3.amazonaws.com"
  source_arn    = aws_s3_bucket.input_bucket.arn
}

// S3 Notification
resource "aws_s3_bucket_notification" "s3_trigger" {
  bucket = aws_s3_bucket.input_bucket.id

  lambda_function {
    lambda_function_arn = aws_lambda_function.polly_lambda.arn
    events              = ["s3:ObjectCreated:*"]
  }

  depends_on = [aws_lambda_permission.s3_permission]
}

// Enable S3 Server-Side Encryption
resource "aws_s3_bucket_server_side_encryption_configuration" "input_enc" {
  bucket = aws_s3_bucket.input_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "output_enc" {
  bucket = aws_s3_bucket.output_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}
//////////////////////////////////////////////////////////////////////////////////////////////////////

// S3 Lifecycle Rule (Cost Control)
resource "aws_s3_bucket_lifecycle_configuration" "input_lifecycle" {
  bucket = aws_s3_bucket.input_bucket.id
  rule {
    id     = "delete-all-audio-after-30-days"
    status = "Enabled"

    filter {} # applies to all objects

    expiration {
      days = 30
    }
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "output_lifecycle" {
  bucket = aws_s3_bucket.output_bucket.id
  rule {
    id     = "delete-all-audio-after-30-days"
    status = "Enabled"

    filter {} # applies to all objects

    expiration {
      days = 30
    }
  }
}

// CloudWatch Log Group for Lambda
resource "aws_cloudwatch_log_group" "lambda_log_group" {
  name              = "/aws/lambda/${aws_lambda_function.polly_lambda.function_name}"
  retention_in_days = 7 # optional, auto-delete after N days
  tags              = var.tags
}