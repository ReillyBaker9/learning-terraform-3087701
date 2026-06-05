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

data "aws_ec2_instance_type_offerings" "free_tier" {
  filter {
    name   = "free-tier-eligible"
    values = ["true"]
  }

  filter {
    name   = "instance-type"
    values = ["t3.micro", "t2.micro", "t4g.micro"]
  }
}

resource "aws_instance" "web" {
  ami           = data.aws_ami.app_ami.id
  instance_type = data.aws_ec2_instance_type_offerings.free_tier.instance_types[0]

  tags = {
    Name = "HelloWorld"
  }
}
