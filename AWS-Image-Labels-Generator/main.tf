# Configure the AWS Provider
// test
provider "aws" {
  region = var.aws_region
}

// S3 Bucket (Image Storage)
resource "aws_s3_bucket" "images_bucket" {
  bucket = "${var.project_name}-images-bucket-${random_id.bucket_id.hex}"

  tags = {
    Name    = "${var.project_name}-bucket"
    Project = var.project_name
  }
}

resource "random_id" "bucket_id" {
  byte_length = 4
}
///////////////////////////////////////////////////////////////////////////////

// Public access blocked
resource "aws_s3_bucket_public_access_block" "block_public_access" {
  bucket = aws_s3_bucket.images_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

// IAM User + Rekognition Permissions
// IAM Policy (Least Privilege)
resource "aws_iam_policy" "rekognition_policy" {
  name        = "${var.project_name}-policy"
  description = "Allow Rekognition label detection and S3 read access"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "rekognition:DetectLabels"
        ]
        Resource = "*"
      },
      {
        Effect = "Allow"
        Action = [
          "s3:GetObject",
          "s3:ListBucket"
        ]
        Resource = [
          aws_s3_bucket.images_bucket.arn,
          "${aws_s3_bucket.images_bucket.arn}/*"
        ]
      }
    ]
  })
}

// IAM User
resource "aws_iam_user" "rekognition_user" {
  name = "${var.project_name}-user"

  tags = {
    Project = var.project_name
  }
}

// Attach Policy to User
resource "aws_iam_user_policy_attachment" "attach_policy" {
  user       = aws_iam_user.rekognition_user.name
  policy_arn = aws_iam_policy.rekognition_policy.arn
}

// Access Keys (For AWS CLI & Python)
resource "aws_iam_access_key" "rekognition_access_key" {
  user = aws_iam_user.rekognition_user.name
}
///////////////////////////////////////////////////////////////////////////////