# DevOps Homelab

A hands-on DevOps learning project where I build and manage a complete infrastructure from scratch using VirtualBox, Ubuntu Server, Terraform, and Ansible.

The goal of this project is to understand how modern infrastructure is provisioned, configured, automated, and maintained by building everything practically instead of relying entirely on managed cloud services.

The project gradually evolves from manually created virtual machines into a fully automated Infrastructure as Code (IaC) environment.

---

## Objectives

- Build a reusable Ubuntu Server Golden Image
- Create a reproducible virtual infrastructure
- Learn Linux system administration
- Configure networking and SSH
- Automate server configuration using Ansible
- Provision infrastructure using Terraform
- Practice Infrastructure as Code (IaC)
- Separate staging and production environments
- Manage secrets securely using Ansible Vault
- Deploy and configure Nginx automatically
- Learn CI/CD concepts
- Deploy applications using Docker
- Implement monitoring and observability
- Explore Kubernetes

---

## Infrastructure

| Hostname        | Role            | Environment | IP Address    |
|-----------------|-----------------|-------------|---------------|
| ansible-control | Automation Node | Control     | 192.168.56.10 |
| web01           | Web Server      | Production  | 192.168.56.11 |
| web02           | Web Server      | Staging     | 192.168.56.12 |
| db01            | Database Server | Database    | 192.168.56.13 |

The infrastructure currently runs inside VirtualBox using a host-only network.

---

## Current Architecture

```text
                         Developer
                            │
                            │ Git
                            ▼
                         GitHub
                            │
                            ▼
                   Ansible Control Node
                   192.168.56.10
                            │
              ┌─────────────┼─────────────┐
              │             │             │
              ▼             ▼             ▼
           web01         web02          db01
        Production       Staging       Database
      192.168.56.11   192.168.56.12  192.168.56.13
```

Ansible acts as the central configuration management system.

Terraform will later be introduced to provision the virtual infrastructure itself.

---

## Current Progress

### Infrastructure

- ✅ Ubuntu Server 24.04.4 LTS Golden Image
- ✅ Automated bootstrap process
- ✅ Golden Image cleanup process
- ✅ First boot initialization
- ✅ Virtual machine cloning
- ✅ Unique machine IDs
- ✅ Unique SSH host keys
- ✅ Hostname configuration
- ✅ Static IP configuration using Netplan
- ✅ Passwordless SSH authentication
- ✅ Host-only VirtualBox networking

### Ansible

- ✅ Ansible control node
- ✅ Inventory configuration
- ✅ Inventory groups
- ✅ Staging and production environments
- ✅ Child inventory groups
- ✅ Ansible playbooks
- ✅ Ansible roles
- ✅ Role-based directory structure
- ✅ Idempotent configuration
- ✅ Jinja2 templates
- ✅ Handlers
- ✅ Tags
- ✅ Group variables
- ✅ Host variables through inventory
- ✅ Ansible facts
- ✅ Dynamic host information using `groups` and `hostvars`
- ✅ Nginx installation
- ✅ Nginx service management
- ✅ Custom Nginx homepage
- ✅ Environment-specific Nginx configuration
- ✅ Dynamic database configuration
- ✅ Ansible Vault
- ✅ Encrypted secrets stored safely in Git
- ✅ Staging/production separation

### CI/CD

- ✅ GitHub Actions self-hosted runner
- ✅ Runner installed on Ansible control node
- ✅ Runner managed using systemd
- ✅ Automatic repository synchronization from GitHub

> The self-hosted runner is currently treated as a learning implementation. Further CI/CD hardening will be added later.

### Documentation

- ✅ Golden Image documentation
- ✅ Ansible documentation
- 🚧 Terraform documentation
- 🚧 Architecture documentation
- 🚧 Final project recap

---

## Repository Structure

```text
devops-homelab/
│
├── ansible/
│   ├── ansible.cfg
│   │
│   ├── inventory/
│   │   ├── hosts.ini
│   │   └── group_vars/
│   │       ├── all/
│   │       │   └── vault.yml
│   │       ├── production.yml
│   │       ├── staging.yml
│   │       └── webservers.yml
│   │
│   ├── playbooks/
│   │   ├── deploy-nginx.yml
│   │   └── install-tools.yml
│   │
│   └── roles/
│       └── nginx/
│           ├── handlers/
│           ├── tasks/
│           └── templates/
│
├── docs/
│   ├── golden-image.md
│   ├── ansible.md
│   ├── terraform.md
│   └── architecture.md
│
├── scripts/
│   ├── bootstrap.sh
│   ├── cleanup.sh
│   └── firstboot.sh
│
├── README.md
└── .gitignore
```

---

## Technologies Used

### Infrastructure

- VirtualBox
- Ubuntu Server 24.04 LTS
- Linux
- OpenSSH
- Netplan

### Configuration Management

- Ansible
- Ansible Vault
- Jinja2

### Version Control & CI/CD

- Git
- GitHub
- GitHub Actions
- GitHub Actions Self-hosted Runner
- systemd

### Planned

- Terraform
- Docker
- Nginx
- Prometheus
- Grafana
- Kubernetes

---

## DevOps Roadmap

### Phase 1 — Infrastructure Foundation

- [x] Build Ubuntu Golden Image
- [x] Configure networking
- [x] Configure SSH
- [x] Clone virtual machines
- [x] Configure unique machine identities
- [x] Create reproducible infrastructure

### Phase 2 — Configuration Management

- [x] Install Ansible
- [x] Configure Ansible control node
- [x] Create inventory
- [x] Create inventory groups
- [x] Create staging and production environments
- [x] Create playbooks
- [x] Learn idempotency
- [x] Create Ansible roles
- [x] Use Jinja2 templates
- [x] Use handlers
- [x] Use tags
- [x] Use group variables
- [x] Use Ansible facts
- [x] Use `groups` and `hostvars`
- [x] Configure Nginx
- [x] Implement dynamic configuration
- [x] Implement Ansible Vault

### Phase 3 — Infrastructure as Code

- [ ] Install Terraform
- [ ] Configure Terraform provider
- [ ] Provision a VM using Terraform
- [ ] Understand Terraform resources
- [ ] Understand Terraform state
- [ ] Use variables
- [ ] Use outputs
- [ ] Create reusable Terraform configuration
- [ ] Provision the complete homelab
- [ ] Connect Terraform provisioning with Ansible configuration

### Phase 4 — Application Deployment

- [ ] Deploy a real application
- [ ] Introduce Docker
- [ ] Containerize the application
- [ ] Configure Docker networking
- [ ] Configure persistent storage
- [ ] Configure Nginx as a reverse proxy

### Phase 5 — CI/CD

- [x] GitHub Actions self-hosted runner
- [x] Automatic repository synchronization
- [ ] Automated infrastructure validation
- [ ] Automated Ansible deployment
- [ ] Staging deployment
- [ ] Production deployment
- [ ] Deployment approval workflow

### Phase 6 — Monitoring

- [ ] Install Prometheus
- [ ] Install Grafana
- [ ] Monitor server resources
- [ ] Monitor applications
- [ ] Create dashboards
- [ ] Configure alerts

### Phase 7 — Containers & Orchestration

- [ ] Learn Docker Compose
- [ ] Deploy multi-container applications
- [ ] Learn Kubernetes fundamentals
- [ ] Build a local Kubernetes cluster
- [ ] Deploy applications to Kubernetes

### Phase 8 — Final Automation

The final goal is to reach a workflow similar to:

```text
Developer
    │
    │ git push
    ▼
GitHub
    │
    ▼
CI/CD
    │
    ├──────────────┐
    ▼              ▼
Terraform       Ansible
    │              │
    ▼              ▼
Infrastructure   Configuration
    │              │
    └───────┬──────┘
            ▼
       Applications
            │
            ▼
       Monitoring
```

---

## Learning Philosophy

This project is intentionally built incrementally.

Instead of simply copying commands, each component is implemented to understand:

- Why it exists
- What problem it solves
- How it interacts with other components
- How it behaves when something fails
- How it can be automated
- How it would be used in a real production environment

The project is therefore both a practical DevOps laboratory and a learning journal.

---

## Purpose

This repository documents my journey of learning DevOps by designing, building, documenting, and automating a complete virtual infrastructure from the ground up.

As the project grows, it will serve as both a personal learning environment and a portfolio demonstrating practical DevOps and Infrastructure as Code skills.