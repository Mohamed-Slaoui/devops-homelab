# DevOps Homelab

A hands-on DevOps learning project where I build and manage a complete infrastructure from scratch using VirtualBox and Ubuntu Server.

The goal of this project is to understand how modern infrastructure is built, automated, and maintained by learning through practical implementation instead of relying on cloud services.

This repository will gradually evolve into a complete Infrastructure as Code (IaC) project covering server provisioning, configuration management, monitoring, containerization, and automation.

---

## Objectives

- Build a reusable Ubuntu Server Golden Image
- Create a reproducible virtual infrastructure
- Learn Linux system administration
- Configure networking and SSH
- Automate infrastructure using Ansible
- Provision infrastructure using Terraform
- Learn Infrastructure as Code (IaC)
- Deploy applications using Docker
- Explore CI/CD and DevOps best practices

---

## Current Infrastructure

| Hostname | Role | IP Address |
|----------|------|------------|
| ansible-control | Automation Node | 192.168.56.10 |
| web01 | Web Server | 192.168.56.11 |
| web02 | Web Server | 192.168.56.12 |
| db01 | Database Server | 192.168.56.13 |

---

## Current Progress

### Infrastructure

- ✅ Ubuntu Server 24.04.4 LTS Golden Image
- ✅ Automated bootstrap process
- ✅ Golden Image cleanup process
- ✅ First boot initialization
- ✅ Virtual machine cloning
- ✅ Unique Machine IDs
- ✅ Unique SSH host keys
- ✅ Hostname configuration
- ✅ Static IP configuration using Netplan
- ✅ Passwordless SSH authentication

### Documentation

- ✅ Golden Image documentation

---

## Repository Structure

```text
devops-homelab/
│
├── ansible/
│   ├── ansible.cfg
│   ├── inventory/
│   └── playbooks/
│
├── docs/
│   └── golden-image.md
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

- Ubuntu Server 24.04 LTS
- VirtualBox
- Linux
- OpenSSH
- Git

> More technologies will be added as the project evolves.

---

## Roadmap

- [x] Build Ubuntu Golden Image
- [x] Configure networking
- [x] Configure SSH
- [ ] Configure Ansible
- [ ] Create Ansible Playbooks
- [ ] Learn Ansible Roles
- [ ] Provision infrastructure with Terraform
- [ ] Deploy applications with Docker
- [ ] Configure Reverse Proxy (Nginx)
- [ ] Build CI/CD Pipeline
- [ ] Monitoring with Prometheus & Grafana
- [ ] Explore Kubernetes

---

## Purpose

This repository documents my journey of learning DevOps by designing, building, documenting, and automating a complete virtual infrastructure from the ground up.

Every configuration, script, and automation is written with the goal of understanding **why** it exists, not just **how** to use it.

As the project grows, this repository will serve both as a personal learning journal and as a portfolio demonstrating practical DevOps skills.