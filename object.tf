provider "aws" {
  profile = "default"
  region  = "ap-south-1"
}
resource "aws_s3_bucket" "example" {
  bucket = var.bucket_name

  tags = {
    Name = "Mybucket"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket_versioning" "example" {
  bucket = aws_s3_bucket.example.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_object" "object" {
  bucket = aws_s3_bucket.example.id
  key    = var.object_key
  source = var.object_path

  # The filemd5() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the md5() function and the file() function:
  # etag = "${md5(file("path/to/file"))}"
  etag = filemd5(var.object_path)
}


