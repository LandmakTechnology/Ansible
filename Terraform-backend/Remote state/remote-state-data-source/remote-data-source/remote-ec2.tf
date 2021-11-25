data "terraform_remote_state" "network" {
  backend = "s3"
  config = {
    bucket = "my-terraformstate-landmark-buc"
    key    = "terraform/terraform.tfstate"
    region = "us-west-1"
  }
}

/*data "terraform_remote_state" "network" {
  backend = "local"
  config = {
      path    = "../remote-data-source/terraform.tfstate"
  }
}*/

resource "aws_instance" "my-ec2"{
  ami = data.aws_ami.amzlinux2.id
  instance_type = "t2.micro"
  subnet_id = data.terraform_remote_state.network.outputs.public_subnets[1]
}
