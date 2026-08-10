terraform {
  required_providers {
    local = {
      source = "hashicorp/local"
    }

    null = {
      source = "hashicorp/null"
    }
  }
}

provider "local" {}
provider "null" {}

locals {
  server_hostname = "web03"
  server_ip       = "192.168.56.14"
  server_user     = "vagrant"
  server_group    = "production"

  vagrant_dir = "${path.module}/../vagrant"
}

# Create the Vagrant VM
resource "null_resource" "create_server" {
  triggers = {
    hostname = local.server_hostname
    ip       = local.server_ip
  }

  provisioner "local-exec" {
    working_dir = local.vagrant_dir

    command = "vagrant up"

    environment = {
      VM_HOSTNAME = local.server_hostname
      VM_IP       = local.server_ip
    }
  }

  provisioner "local-exec" {
    when        = destroy
    command     = "vagrant destroy -f"
    working_dir = "${path.module}/../vagrant"
  }
}

# Automatically update Ansible inventory
resource "null_resource" "update_ansible_inventory" {
  depends_on = [null_resource.create_server]

  triggers = {
    hostname = local.server_hostname
    ip       = local.server_ip
    user     = local.server_user
    group    = local.server_group
  }

  # Add server to inventory
  provisioner "local-exec" {
    command = "python ${path.module}/update_inventory.py --inventory ${path.module}/../ansible/inventory/hosts.ini --group ${local.server_group} --hostname ${local.server_hostname} --ip ${local.server_ip} --user ${local.server_user}"
  }

  # Remove server from inventory when destroyed
  provisioner "local-exec" {
    when = destroy

    command = "python ${path.module}/remove_inventory.py --inventory ${path.module}/../ansible/inventory/hosts.ini --hostname ${self.triggers.hostname}"
  }
}

output "server_ip" {
  description = "IP address of the server"
  value       = local.server_ip
}