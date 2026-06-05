variable "instance_type" {
  description = "EC2 instance type - must be free-tier eligible in your region (t3.micro or t2.micro)"
  default     = "t3.micro"
}

data "aws_ami" "app_ami" {
  most_recent = true

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["amazon"]
}

resource "aws_instance" "web" {
  ami           = data.aws_ami.app_ami.id
  instance_type = var.instance_type

  tags = {
    Name = "HelloWorld"
  }
}
