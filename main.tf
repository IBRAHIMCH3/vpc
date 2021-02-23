provider "aws" {
  region     = "ap-south-1"
}


module "SEAAWSDVA505" {
  source                 = "terraform-aws-modules/ec2-instance/aws"
  version                = "~> 2.0"

  name                   = "SEAAWSDVA505"
  instance_count         = 1

  ami                    = "ami-08e0ca9924195beba"
  instance_type          = "t2.micro"

  key_name               = "Ochkey"
  monitoring             = true
  vpc_security_group_ids = ["sg-0320d405e6fb2ee70"]
  subnet_id              = "subnet-9896d4d4"
  #delete_on_termination  = true


  root_block_device = [{
    volume_size           = "10"
    volume_type           =  "gp2"
    delete_on_termination =  true
    encrypted         = true
  }]

  tags = {
    Terraform   = "SEAAWSDVA505"
    Environment = "Dev-1"
    }

 }

resource "aws_dynamodb_table" "terraform_locks" {
  name         = "terraform-running-locks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
}
