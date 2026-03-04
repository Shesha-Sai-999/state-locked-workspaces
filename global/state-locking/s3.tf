resource "aws_s3_bucket" "prj1-terra" {
  bucket = var.bucket_name

  tags = {
    Name   = var.bucket_name
  }
}