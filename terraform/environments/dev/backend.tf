terraform {
  backend "s3" {
    bucket         = "my-project-tf-state-us-east-1"
    key            = "devterraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-ha-dev-locks"
    encrypt        = true
  }
}