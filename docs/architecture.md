# Homelab Architecture

This document describes the architecture of the DevOps homelab and how its components interact.

---

## Current Infrastructure

The infrastructure consists of four Ubuntu Server virtual machines running inside VirtualBox.

| Hostname | Role | Environment | IP |
|---|---|---|---|
| ansible-control | Automation | Control | 192.168.56.10 |
| web01 | Web Server | Production | 192.168.56.11 |
| web02 | Web Server | Staging | 192.168.56.12 |
| db01 | Database Server | Database | 192.168.56.13 |

---

## Network

The virtual machines communicate through a VirtualBox host-only network.

```text
                    Host Machine
                         │
                  Host-only Network
                  192.168.56.0/24
                         │
        ┌────────────────┼────────────────┐
        │                │                │
        ▼                ▼                ▼
 ansible-control       web01            web02
 192.168.56.10     192.168.56.11    192.168.56.12
                         │
                         │
                         ▼
                       db01
                   192.168.56.13
```

---

## Configuration Management

Ansible runs from `ansible-control`.

```text
                 ansible-control
                       │
                 SSH / Ansible
                       │
        ┌──────────────┼──────────────┐
        ▼              ▼              ▼
      web01          web02           db01
   production       staging        database
```

The control node stores:

- Inventory
- Playbooks
- Roles
- Templates
- Variables
- Encrypted secrets

---

## Git Workflow

The repository is hosted on GitHub.

The general workflow is:

```text
Developer
    │
    │ git push
    ▼
GitHub
    │
    ▼
ansible-control
```

The repository on the Ansible control node is synchronized with GitHub.

---

## CI/CD

A GitHub Actions self-hosted runner was configured on the Ansible control node.

The runner allows GitHub Actions jobs to execute inside the homelab environment.

The initial implementation is intentionally simple:

```text
GitHub
   │
   │ Push
   ▼
GitHub Actions
   │
   ▼
Self-hosted Runner
   │
   ▼
ansible-control
   │
   └── Sync repository
```

More advanced deployment automation will be introduced later.

---

## Environments

The web infrastructure is separated into:

```text
webservers
├── production
│   └── web01
│
└── staging
    └── web02
```

This allows the same automation to target different environments.

For example:

```bash
ansible staging -m ping
```

targets only the staging server.

While:

```bash
ansible production -m ping
```

targets only production.

---

## Configuration Management Flow

Ansible combines inventory information, variables, facts, templates, and roles.

```text
Inventory
    │
    ├── Groups
    ├── Hosts
    └── Variables
         │
         ▼
      Playbook
         │
         ▼
        Role
     ┌───┼────┐
     │   │    │
   Tasks Templates Handlers
     │   │    │
     └───┼────┘
         ▼
     Target Server
```

---

## Dynamic Configuration

Ansible can use information about one host while configuring another.

For example:

```text
db01
192.168.56.13
   │
   │ hostvars
   ▼
Ansible
   │
   ▼
web01 / web02
```

This allows generated configuration files to reference the database server without hardcoding its address into every template.

---

## Secrets

Sensitive configuration is stored using Ansible Vault.

```text
inventory/group_vars/all/
└── vault.yml
       │
       │ encrypted
       ▼
     GitHub
```

The encrypted file can be version controlled, while the Vault password remains outside the repository.

---

## Target Architecture

Terraform will later be introduced to provision the infrastructure itself.

The target architecture is:

```text
                         Developer
                             │
                             │ Git
                             ▼
                          GitHub
                             │
                 ┌───────────┴───────────┐
                 │                       │
                 ▼                       ▼
             Terraform              Ansible
                 │                       │
                 ▼                       │
             VirtualBox                  │
                 │                       │
        ┌────────┼────────┐              │
        ▼        ▼        ▼              │
     web01     web02     db01            │
        │        │        │              │
        └────────┼────────┴──────────────┘
                 │
                 ▼
          Configured System
```

Terraform will answer:

> What infrastructure should exist?

Ansible will answer:

> How should that infrastructure be configured?

---

## Long-Term Architecture

The eventual goal is to evolve the homelab toward:

```text
Developer
    │
    ▼
GitHub
    │
    ▼
CI/CD
    │
    ├───────────────┐
    ▼               ▼
Terraform         Ansible
    │               │
    ▼               ▼
Infrastructure   Configuration
    │               │
    └───────┬───────┘
            ▼
       Applications
            │
       ┌────┴────┐
       ▼         ▼
    Docker     Nginx
       │
       ▼
   Monitoring
       │
   ┌───┴────┐
   ▼        ▼
Prometheus Grafana
       │
       ▼
   Kubernetes
```

This architecture will evolve gradually as each technology is introduced and understood.