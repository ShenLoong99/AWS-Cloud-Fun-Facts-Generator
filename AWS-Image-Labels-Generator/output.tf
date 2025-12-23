output "s3_bucket_name" {
  description = "S3 bucket name for image uploads"
  value       = aws_s3_bucket.images_bucket.bucket
}

output "iam_user_name" {
  description = "IAM user for Rekognition access"
  value       = aws_iam_user.rekognition_user.name
}