provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "foo" {
  ami           = "ami-03bb6d83c60fc5f7c"
  instance_type = "t3.small"

  tags = {
    Name = "jenkins-nonprod-deploy"
  }
}
