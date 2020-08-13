
provider "aws" {
  region = "us-west-2"
}

resource "aws_key_pair" "example" {
  key_name   = "example-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCxev77gVGLWqCPaOqeBdCvExMESV+XvsPKhLh9V9JpmSsyZhL8idI7jDdpu8qKIKH/hhwVb15qt43cza27C4JbpHDhyzUdm1nkEtn9guiI9OR63X0TId1rCRgiGIMULWElcrrVnjmIgo5/8hleF2DWkv+sx6p0dWDMtAjH961A1ge6o+v/tZg2D9aqBI+veifiDePXxnv/ZtSbxMMgRibPxE4XhyDOOmklKRhRIxq4zcuSh76U5ijzGyf87I6jS9/Ggekpr2hh4LmaqJk+LQvOlnMTZWDHe8ARHSPlw8RKRKK6HAKdjzdieU915DSemeifoDAFPSEwPhji0jy6cqbV adam@dantePC"
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

}