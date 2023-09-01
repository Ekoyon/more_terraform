terraform {
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "~> 3.0"
        }
    }
}
provider "aws" {
    region = "us-east-1"
}

resource "aws_instance" "day58" {
    ami = "ami-053b0d53c279acc90"
    instance_type = "t2.micro"
    availability_zone = "us-east-1a"
  
    user_data = <<-EOF
            #!/bin/bash
            sudo yum update
            sudo yum install -y httpd
            sudo systemctl start httpd
            sudo systemctl enable httpd
            echo "<h1>AWS AMI Deployed through Terraform<h1>" | sudo tee /var/html/index.html
                EOF
    tags = {
        name = "created using terraform"
    }
}
