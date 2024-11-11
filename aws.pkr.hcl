variable "aws_access_key" {
  type    = string
  default = "${env("AWS_ACCESS_KEY")}"
}

variable "aws_secret_key" {
  type    = string
  default = "${env("AWS_SECRET_KEY")}"
}

packer {
  required_plugins {
    amazon = {
      version = ">= 1.3.2",
      source  = "github.com/hashicorp/amazon",
    }
  }
}

source "amazon-ebs" "ubuntu" {
  ami_name      = "module-2-provisioning-v4"
  instance_type = "t2.micro"
  region        = "eu-west-1"
  source_ami    = "ami-0d64bb532e0502c46"
  subnet_filter {
    filters = {
      "tag:Tier" : "public"
    }
    most_free = true
    random    = false
  }
  ssh_username = "ubuntu"
  tags = {
    name       = "ami-module-2-provisioning"
    owner      = "cheikh"
    Module     = "devops-essentials"
    Gitpath    = ":lcf-externalmodule-2-provisioning/"
    DeployedBy = "packer"
  }
}

build {
  sources = ["source.amazon-ebs.ubuntu"]
  name    = "my-ami-v2"
  provisioner "shell" {
    inline = [
      "sudo apt-get update",
      "sudo DEBIAN_FRONTEND=noninteractive apt-get upgrade -y",
      "sudo DEBIAN_FRONTEND=noninteractive apt-get install -y python3 python3-dev",
      "sudo DEBIAN_FRONTEND=noninteractive -H apt-get install -y python3",
      "sudo DEBIAN_FRONTEND=noninteractive -H apt-get install -y python3-pip",
      "sudo DEBIAN_FRONTEND=noninteractive -H apt-get install -y ansible",
    "ansible --version", ]
  }
 # Upload index.html template file to the remote instance
  provisioner "file" {
    source      = "./ansible/index.html"
    destination = "/tmp/index.html"
  }
  provisioner "ansible-local" {
    playbook_file = "./ansible/playbook.yml"
  }
}