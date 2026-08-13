terraform {
  required_providers {
    null = {
      source = "hashicorp/null"
    }
    local = {
      source = "hashicorp/local"
    }
  }
}

provider "null" {}
provider "local" {}

locals {
  vms = {
    web01 = {
      ip     = "192.168.56.10"
      group  = "production"
      user   = "vagrant"
      memory = 2048
      cpus   = 2
    }

    web02 = {
      ip     = "192.168.56.11"
      group  = "staging"
      user   = "vagrant"
      memory = 2048
      cpus   = 2
    }

    web03 = {
      ip     = "192.168.56.12"
      group  = "production"
      user   = "vagrant"
      memory = 2048
      cpus   = 2
    }

    db01 = {
      ip     = "192.168.56.13"
      group  = "database"
      user   = "vagrant"
      memory = 4096
      cpus   = 2
    }
  }

  inventory = "${path.module}/../ansible/inventory/hosts.ini"
}

# ============================================================
# Vagrant machine definitions (read by vagrant/Vagrantfile)
# ============================================================

resource "local_file" "vagrant_machines" {
  filename = "${path.module}/../vagrant/machines.json"
  content = jsonencode({
    for name, vm in local.vms :
    name => {
      ip     = vm.ip
      memory = vm.memory
      cpus   = vm.cpus
      box    = "bento/ubuntu-24.04"  # Use a suitable Vagrant box
    }
  })
}

# ============================================================
# Vagrant VMs (native Windows vagrant.exe / VirtualBox)
# Run with: terraform apply -parallelism=1
# ============================================================

resource "null_resource" "vagrant_vm" {
  for_each = local.vms

  depends_on = [local_file.vagrant_machines]

  triggers = {
    hostname = each.key
    ip       = each.value.ip
    memory   = each.value.memory
    cpus     = each.value.cpus
  }

  provisioner "local-exec" {
    command     = "vagrant up ${each.key}"
    working_dir = "${path.module}/../vagrant"
  }

  provisioner "local-exec" {
    when        = destroy
    command     = "vagrant destroy -f ${self.triggers.hostname}"
    working_dir = "${path.module}/../vagrant"
  }
}

# ============================================================
# Ansible inventory
# ============================================================

resource "null_resource" "update_ansible_inventory" {
  for_each = local.vms

  depends_on = [
    null_resource.vagrant_vm
  ]

  triggers = {
    hostname = each.key
    ip       = each.value.ip
    user     = each.value.user
    group    = each.value.group
  }

  provisioner "local-exec" {
    command = "python ${path.module}/update_inventory.py --inventory ${local.inventory} --group ${each.value.group} --hostname ${each.key} --ip ${each.value.ip} --user ${each.value.user}"
  }
}

# ============================================================
# Configure machines with Ansible (only Ansible runs in WSL)
# ============================================================

resource "null_resource" "ansible_configure" {
  depends_on = [
    null_resource.update_ansible_inventory
  ]

  triggers = {
    infrastructure = join(
      ",",
      [
        for name, vm in local.vms :
        "${name}-${vm.ip}-${vm.group}-${vm.memory}-${vm.cpus}"
      ]
    )
  }

  provisioner "local-exec" {
    interpreter = ["wsl.exe", "-d", "Ubuntu", "bash", "-lc"]
    command     = "cd /mnt/e/Self-Taught/DevOps/Infrastructure/devops-homelab && bash scripts/deploy-server.sh"
  }
}

# ============================================================
# Outputs
# ============================================================

output "server_ips" {
  description = "IP addresses of all managed servers"

  value = {
    for name, vm in local.vms :
    name => vm.ip
  }
}