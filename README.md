# DevOps Homelab

A hands-on DevOps learning project where I build and manage a complete virtual infrastructure from scratch using VirtualBox and Ubuntu Server.

The goal of this project is to understand how modern infrastructure is built, automated, and maintained through practical implementation rather than relying entirely on managed cloud services.

The project is gradually evolving into an Infrastructure as Code (IaC) environment covering infrastructure provisioning, configuration management, application deployment, CI/CD, monitoring, containerization, and automation.

---

## Objectives

- Build a reusable Ubuntu Server Golden Image
- Create a reproducible virtual infrastructure
- Learn Linux system administration
- Configure networking and SSH
- Automate server configuration using Ansible
- Learn Infrastructure as Code (IaC)
- Provision infrastructure using Terraform
- Deploy applications using Docker
- Build CI/CD pipelines
- Implement monitoring and observability
- Explore Kubernetes

---

## Current Infrastructure

| Hostname        | Role            | IP Address    |
|-----------------|-----------------|---------------|
| ansible-control | Automation Node | 192.168.56.10 |
| web01           | Web Server      | 192.168.56.11 |
| web02           | Web Server      | 192.168.56.12 |
| db01            | Database Server  | 192.168.56.13 |

All virtual machines run Ubuntu Server and communicate through a private VirtualBox network.

---

## Current Progress

### Virtual Infrastructure

- ✅ Ubuntu Server 24.04.4 LTS Golden Image
- ✅ Automated bootstrap process
- ✅ Golden Image cleanup process
- ✅ First-boot initialization
- ✅ Virtual machine cloning
- ✅ Unique machine IDs
- ✅ Unique SSH host keys
- ✅ Hostname configuration
- ✅ Static IP configuration using Netplan
- ✅ Passwordless SSH authentication
- ✅ Dedicated Ansible control node
- ✅ Web server group
- ✅ Database server group

### Ansible

- ✅ Ansible installed and configured
- ✅ Inventory configuration
- ✅ SSH-based Ansible communication
- ✅ Ansible ad-hoc commands
- ✅ Ansible facts
- ✅ Package management with Ansible
- ✅ Ansible playbooks
- ✅ Idempotent configuration
- ✅ Nginx deployment
- ✅ Jinja2 templates
- ✅ Ansible handlers
- ✅ Ansible roles
- ✅ Nginx role
- ✅ Custom dynamic web pages generated from server facts

### CI/CD

- ✅ GitHub repository
- ✅ Git-based infrastructure management
- ✅ GitHub Actions self-hosted runner
- ✅ Automatic repository synchronization on push to `main`
- ⏳ Runner persistence/reliability improvements

### Documentation

- ✅ Golden Image documentation
- ⏳ Ansible documentation
- ⏳ Infrastructure architecture documentation
- ⏳ CI/CD documentation

---

## Repository Structure

```text
devops-homelab/
│
├── ansible/
│   ├── ansible.cfg
│   ├── inventory/
│   │   └── hosts.ini
│   │
│   ├── playbooks/
│   │   ├── deploy-nginx.yml
│   │   └── install-tools.yml
│   │
│   └── roles/
│       └── nginx/
│           ├── handlers/
│           │   └── main.yml
│           ├── tasks/
│           │   └── main.yml
│           └── templates/
│               └── index.html.j2
│
├── docs/
│   ├── golden-image.md
│   └── ansible.md
│
├── scripts/
│   ├── bootstrap.sh
│   ├── cleanup.sh
│   └── firstboot.sh
│
├── README.md
└── .gitignore