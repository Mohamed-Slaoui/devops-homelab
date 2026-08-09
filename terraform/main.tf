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
}