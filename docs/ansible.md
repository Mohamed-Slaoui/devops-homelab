# Ansible

Ansible is the configuration management and automation tool used in this homelab to configure and manage the virtual servers.

The Ansible control node connects to the managed servers over SSH and executes tasks remotely.

---

## 1. Ansible Architecture

The current infrastructure uses one dedicated Ansible control node:

```text
                    Ansible Control Node
                    192.168.56.10
                           │
                    SSH / Ansible
                           │
             ┌─────────────┼─────────────┐
             │             │             │
             ▼             ▼             ▼
          web01          web02          db01
       192.168.56.11  192.168.56.12  192.168.56.13