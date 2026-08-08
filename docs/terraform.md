# Terraform

Terraform will be introduced as the Infrastructure as Code (IaC) layer of the homelab.

Currently, the VirtualBox virtual machines are created and configured manually.

The goal of introducing Terraform is to make the infrastructure itself reproducible.

---

## Terraform vs Ansible

The two tools solve different problems.

### Terraform

Terraform will manage the infrastructure lifecycle:

```text
What infrastructure should exist?
```

For example:

- Virtual machines
- CPU
- RAM
- Disk
- Network interfaces
- VirtualBox configuration

### Ansible

Ansible manages the configuration of existing machines:

```text
How should the machines be configured?
```

For example:

- Install Nginx
- Configure services
- Deploy files
- Configure users
- Manage application configuration

---

## Target Workflow

The intended workflow is:

```text
Terraform
    │
    ▼
Create Virtual Machines
    │
    ▼
Ansible
    │
    ▼
Configure Virtual Machines
```

Terraform creates the infrastructure.

Ansible configures it.

---

## Planned Terraform Work

- [ ] Install Terraform
- [ ] Understand providers
- [ ] Configure VirtualBox provider
- [ ] Create first Terraform resource
- [ ] Provision one VM
- [ ] Understand Terraform state
- [ ] Use variables
- [ ] Use outputs
- [ ] Create reusable configuration
- [ ] Provision the complete homelab
- [ ] Connect Terraform with Ansible

---

## Important Concepts to Learn

### Providers

Providers allow Terraform to communicate with infrastructure platforms.

For this project, the initial target will be VirtualBox.

### Resources

Resources represent infrastructure that Terraform manages.

Conceptually:

```text
Terraform
    │
    ▼
Resource
    │
    ▼
Virtual Machine
```

### State

Terraform maintains a state file describing the infrastructure it manages.

The state allows Terraform to determine:

- What already exists
- What changed
- What needs to be created
- What needs to be modified
- What needs to be destroyed

### Plan

Terraform can show what it intends to change before applying those changes.

### Apply

Terraform applies the planned infrastructure changes.

---

## Future Architecture

Once Terraform is implemented:

```text
GitHub
   │
   ▼
Terraform
   │
   ▼
VirtualBox
   │
   ├── ansible-control
   ├── web01
   ├── web02
   └── db01
            │
            ▼
         Ansible
            │
            ▼
       Configuration
```

The Terraform implementation will be documented here as the project progresses.