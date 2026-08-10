terraform {
  required_providers {
    multipass = {
      source  = "larstobi/multipass"
      version = "1.4.3"
    }

    local = {
      source  = "hashicorp/local"
      }
  }
}

provider "multipass" {}
provider "local" {}

resource "multipass_instance" "web03" {
  name   = "web03"
  cpus   = 2
  memory = "2GiB"
  image  = "jammy"

  cloudinit_file = "${path.module}/cloud-init.yaml"
}

resource "local_file" "ansible_web03_inventory" {
  filename = "${path.module}/../ansible/inventory/web03.ini"

  content = templatefile(
    "${path.module}/ansible-web03.tftpl",
    {
      web03_ip = multipass_instance.web03.ipv4
    }
  )
}

output "web03_ip" {
  description = "IP address of the production web03 server"
  value       = multipass_instance.web03.ipv4
}