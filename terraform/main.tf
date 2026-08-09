terraform {
  required_providers {
    multipass = {
      source  = "larstobi/multipass"
      version = "1.4.3"
    }
  }
}

provider "multipass" {}

resource "multipass_instance" "test_node" {
  name   = "terraform-test"
  cpus   = 1
  memory = "1GiB"
  image  = "jammy"
}