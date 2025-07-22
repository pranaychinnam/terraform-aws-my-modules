provider "aws" {
    region = "us-east-1"  
}

# resource "aws_instance" "foo" {
#   ami           = "ami-05fa00d4c63e32376" # us-west-2
#   instance_type = "t2.micro"
#   tags = {
#       Name = "TF-jenkins-Instance"
#   }
# }


# provider "aws" {
#   region = "ap-south-1"
# }

resource "aws_instance" "example" {
  ami           = "ami-03bb6d83c60fc5f7c"  # Amazon Linux 2023 (Mumbai)
  instance_type = "t2.micro"

  tags = {
    Name = "Jenkins-TF-EC2"
  }
}
