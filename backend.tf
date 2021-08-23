terraform {
  backend "s3" {
    bucket = "jenkinshandson"
    key    = "terraform/app"
    region = "us-east-1"
  }
}