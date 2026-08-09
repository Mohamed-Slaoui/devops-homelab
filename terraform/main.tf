terraform {
  required_providers {
    multipass = {
      source  = "larstobi/multipass"
      version = "1.4.3"
    }
  }
}

provider "multipass" {}

resource "multipass_instance" "web03" {
  name   = "web03"
  cpus   = 2
  memory = "2GiB"
  image  = "jammy"

  cloudinit_file = "${path.module}/cloud-init.yaml"
}

output "web03_ip" {
  description = "IP address of the production web03 server"
  value       = multipass_instance.web03.ipv4
}