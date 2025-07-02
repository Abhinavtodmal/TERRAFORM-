output "ec2_public_ip" {
     value = aws_instance.my_instance.public_ip
  
}

# When you create an EC2 instance with Terraform, user_data lets you give a shell script (usually bash) that:

# ✔ Installs software
# ✔ Updates the system
# ✔ Configures the server
# ✔ Runs any custom commands