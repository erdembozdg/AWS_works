
provider "aws" {
  region = "us-west-2"
}

resource "aws_key_pair" "example" {
  key_name   = "example-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCn33IVfCRzzQawvF//EF68M67+uxbcpU63hjbGW5xzbrvBpPx8JXRzH40x4Zp37cKIh2ZQxZXsMv3l8D1UNw4iG7iilr6sPCgP1HZhVE6DZGvMqqpx8x5JinUyMn4q4EEczez1eVj7OiwRhYf3gou83uB7G9m9p4+tiEsuZrGbL2q0ivnJNS9kAMsswOYKX6vAhTDtIH+ptMMEQsfSbi/MxIVo4Pb0W4QfpCwYy18rirwZ5eyGmqkZYFV57wQath4Y0v1y43t0UIulVipGG1MlpJZMwNTCqx/Ur9xLp9RizCUxcAeWAzi9oO+uhX6pr+rQ8wbzKVaoVncXIeHuod7ZN+mjw903jIdWjYIgYfDIjxtf27Il67hMd2HpYNnc2i3/dndYVebY7M1UWbJqeXHzoFLKPQCOiRCNJ4WNWdAgqTjhfb7Lx2P8JcF2y6b7NFOrS6pAJ/j3eV5u8Q8tVuV1gnH8rg38RthUdTp/d1h2oR2wKNdqw4APEz6HuIzKFw8= erdem@DESKTOP-9L2TM1M"
}

resource "aws_security_group" "examplesg" {
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "ec2_instance" {
  ami                    = "ami-28e07e50"
  instance_type          = "t2.micro"
  vpc_security_group_ids = ["${aws_security_group.examplesg.id}"]
  key_name               = "${aws_key_pair.example.id}"

  tags = {    Name = "terraform-example"  }
}