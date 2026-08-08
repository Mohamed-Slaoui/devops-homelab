# Ansible

Ansible is used in this project for configuration management and server automation.

The Ansible control node manages the other servers remotely using SSH.

---

## Architecture

```text
                    Ansible Control
                    192.168.56.10
                          │
              ┌───────────┼───────────┐
              │           │           │
              ▼           ▼           ▼
            web01       web02       db01
         Production     Staging    Database
       192.168.56.11 192.168.56.12 192.168.56.13
```

The control node contains the Ansible configuration, inventory, playbooks, and roles.

---

## Directory Structure

```text
ansible/
│
├── ansible.cfg
│
├── inventory/
│   ├── hosts.ini
│   │
│   └── group_vars/
│       ├── all/
│       │   └── vault.yml
│       ├── production.yml
│       ├── staging.yml
│       └── webservers.yml
│
├── playbooks/
│   ├── deploy-nginx.yml
│   └── install-tools.yml
│
└── roles/
    └── nginx/
        ├── handlers/
        │   └── main.yml
        ├── tasks/
        │   └── main.yml
        └── templates/
            ├── index.html.j2
            └── database.conf.j2
```

---

## Inventory

The inventory defines the infrastructure managed by Ansible.

Example:

```ini
[control]
ansible-control ansible_connection=local

[production]
web01 ansible_host=192.168.56.11

[staging]
web02 ansible_host=192.168.56.12

[webservers:children]
production
staging

[database]
db01 ansible_host=192.168.56.13

[all:vars]
ansible_user=ubuntu
```

This creates the following structure:

```text
webservers
├── production
│   └── web01
│
└── staging
    └── web02
```

The `webservers:children` configuration allows the parent group to contain both environments.

---

## Testing Inventory

Display the inventory graph:

```bash
ansible-inventory --graph
```

Display variables for a specific host:

```bash
ansible-inventory --host web01
```

Test connectivity:

```bash
ansible webservers -m ping
```

---

## Playbooks

Playbooks describe what Ansible should do.

Example:

```yaml
- name: Deploy Nginx
  hosts: webservers
  become: true

  roles:
    - nginx
```

The playbook does not contain the detailed Nginx implementation.

That responsibility belongs to the `nginx` role.

---

## Roles

Roles organize reusable Ansible automation.

The Nginx role contains:

```text
roles/nginx/
├── handlers/
├── tasks/
└── templates/
```

### Tasks

Tasks describe actions that Ansible should perform.

Examples:

- Install Nginx
- Start Nginx
- Deploy configuration
- Deploy the homepage

### Templates

Templates are Jinja2 files used to generate dynamic configuration.

### Handlers

Handlers are triggered when a task reports a change.

For example:

```yaml
notify: Restart nginx
```

The Nginx restart handler only runs when the relevant configuration changes.

---

## Idempotency

Ansible is designed to be idempotent.

For example:

```yaml
- name: Install nginx
  apt:
    name: nginx
    state: present
```

If Nginx is already installed, Ansible does not reinstall it.

Running the playbook repeatedly should eventually result in:

```text
changed = 0
```

when the target system already matches the desired state.

---

## Templates

Jinja2 templates allow dynamic values to be inserted into files.

Example:

```html
<h2>{{ ansible_hostname }}</h2>

<p>Environment: {{ server_environment }}</p>

<p>IP Address: {{ ansible_default_ipv4.address }}</p>

<p>OS: {{ ansible_distribution }} {{ ansible_distribution_version }}</p>
```

Ansible renders the template separately for each server.

Therefore:

```text
web01 → Production
web02 → Staging
```

can display different information while using the same template.

---

## Ansible Facts

Facts are automatically gathered information about the target machine.

Examples:

```text
ansible_hostname
ansible_distribution
ansible_distribution_version
ansible_default_ipv4.address
```

They can be used directly in templates.

For example:

```jinja2
{{ ansible_hostname }}
```

can produce:

```text
web01
```

---

## Inventory Variables

Variables can be associated with inventory groups.

The project uses:

```text
inventory/group_vars/
├── production.yml
├── staging.yml
└── webservers.yml
```

This allows different environments to use different values while sharing the same playbooks and roles.

---

## `groups`

Ansible automatically provides a `groups` variable containing the inventory groups.

For example:

```yaml
groups['database']
```

can return:

```text
['db01']
```

This allows automation to discover hosts based on their inventory group.

---

## `hostvars`

`hostvars` provides access to variables belonging to other inventory hosts.

For example:

```yaml
hostvars[groups['database'][0]]['ansible_host']
```

can resolve to:

```text
192.168.56.13
```

This was used to dynamically generate database configuration on the web servers.

Example:

```text
DATABASE_HOST=192.168.56.13
DATABASE_PORT=3306
```

The database address does not need to be hardcoded into the web server template.

---

## Tags

Tags allow specific tasks to be selected.

For example:

```yaml
tags:
  - config
```

A playbook can then execute only configuration tasks:

```bash
ansible-playbook playbooks/deploy-nginx.yml --tags config
```

List available tags:

```bash
ansible-playbook playbooks/deploy-nginx.yml --list-tags
```

---

## Ansible Vault

Sensitive values should not be stored as plaintext in Git.

Examples of secrets include:

- Database passwords
- API keys
- Service credentials
- Private tokens

The project stores encrypted secrets in:

```text
inventory/group_vars/all/vault.yml
```

The file can safely exist in the Git repository because its contents are encrypted.

To view it:

```bash
ansible-vault view inventory/group_vars/all/vault.yml
```

To edit it:

```bash
ansible-vault edit inventory/group_vars/all/vault.yml
```

To run automation requiring the Vault:

```bash
ansible-playbook playbooks/deploy-nginx.yml --ask-vault-pass
```

The Vault password itself must never be committed to Git.

---

## Configuration Flow

The current Ansible workflow can be summarized as:

```text
Inventory
    │
    ├── Hosts
    ├── Groups
    └── Variables
         │
         ▼
Playbook
    │
    ▼
Role
    │
    ├── Tasks
    ├── Templates
    └── Handlers
         │
         ▼
Target Servers
```

---

## Current Ansible Capabilities

The homelab currently demonstrates:

- Inventory management
- Group hierarchy
- Staging/production separation
- Playbooks
- Roles
- Tasks
- Idempotency
- Variables
- Group variables
- Facts
- Jinja2 templates
- Handlers
- Tags
- Dynamic cross-host configuration
- Ansible Vault
- Automated Nginx deployment

---

## Future Ansible Work

The Ansible implementation will later be extended to configure:

- Docker
- Application servers
- Database servers
- Reverse proxies
- Monitoring agents
- Application deployments
- Production deployment workflows