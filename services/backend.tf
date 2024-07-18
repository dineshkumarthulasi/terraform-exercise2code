terraform {
  backend "s3" {
    bucket         = "terraformexercise2bucket"
    key            = "terraform/state"
    region         = "us-east-1"
  }
}
