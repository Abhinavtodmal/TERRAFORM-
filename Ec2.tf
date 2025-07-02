#key pair 
 
 resource "aws_key_pair" "my_key" {
  key_name   = "terra-key-ec2"
  public_key = file("terra-key-ec2.pub")
}

#VPC and Security Group

resource "aws_default_vpc" "default" {
  tags = {
    Name = "Default VPC"
  }
}




resource "aws_security_group" "my_security_group" {
    name    = "my_security_group"
    description = "Allow SSH and HTTP access"
    vpc_id = aws_default_vpc.default.id  #interpolation 
    
    ingress  {
         from_port  =22
         to_port = 22
         protocol = "tcp"
         cidr_blocks = ["0.0.0.0/0"]
         description ="SSH Open"
    }

     ingress  {
         from_port  = 80
         to_port = 80
         protocol = "tcp"
         cidr_blocks = ["0.0.0.0/0"]
         description ="HTTP Open"
    }

    egress  {
        from_port = 0
        to_port = 0
        protocol = "-1" # -1 means all protocols
         cidr_blocks = ["0.0.0.0/0"]
         description ="All acsess open Outbound"
    }
}
# EC2 Instance

resource "aws_instance" "my_instance" {
  key_name = aws_key_pair.my_key.key_name
  security_groups = [aws_security_group.my_security_group.name]
  instance_type = "t2.micro"
  ami = "ami-0c803b171269e2d72"
  
  root_block_device {
    volume_size = 8
    volume_type = "gp3"
  }
  tags = {
    Name = "JayGanesh"
  }
}