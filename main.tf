terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  # Configuration options
  region = var.region
  // Requires ENV variable AWS_ACCESS_KEY_ID
  // Requires ENV variable AWS_SECRET_ACCESS_KEY
}

data "aws_subnet" "vm_subnet" {
  filter {
    name   = "tag:AciPolicyDnTag"
    values = [var.subnet_dn]
  }
}

data "aws_eip" "web" {
  id = var.eip_aws_id
}

resource "aws_network_interface" "nic1" {
  subnet_id   = data.aws_subnet.vm_subnet.id

  tags = {
    Name = "primary_network_interface"
  }
}

resource "aws_instance" "web" {
  ami           = "ami-0b76ed4ce82bfb4b6"
  instance_type = "t2.medium"
  key_name      = var.ssh_key_name
  tags = {
    Name = var.vm_name,
    EPG  = "Web"
  }

  network_interface {
    network_interface_id = aws_network_interface.nic1.id
    device_index         = 0
  }

  user_data = <<EOF
    #cloud-config
    runcmd:
    - "sed -i 's/10.101.0.11/${var.db_ip_address}/g' /etc/hosts"
  EOF
}

resource "aws_eip_association" "web" {
  instance_id          = aws_instance.web.id
  network_interface_id = aws_network_interface.nic1.id
  allocation_id        = data.aws_eip.web.id
}