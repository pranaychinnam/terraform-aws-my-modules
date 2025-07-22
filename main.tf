provider "aws" {
    region = "us-east-1"  
}
resource "aws_instance" "example" {
  ami           = "ami-0cbbe2c6a1bb2ad63"  # Amazon Linux 2023 (Mumbai)
  instance_type = "t2.micro"

  tags = {
    Name = "Jenkins-TF-EC2"
  }
}
