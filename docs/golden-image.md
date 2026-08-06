# Ubuntu Golden Image

## Overview

To avoid repeating the same installation and configuration steps for every virtual machine, a reusable Ubuntu Server Golden Image was created.

This image acts as a clean template that can be cloned into multiple servers while ensuring each clone generates its own unique identity during its first boot.

## Objectives

- Create a reusable Ubuntu Server template.
- Minimize manual server provisioning.
- Ensure every cloned VM has a unique identity.
- Prepare the infrastructure for Ansible automation.

## Base System

- Ubuntu Server 24.04.4 LTS
- VirtualBox
- OpenSSH Server

## Bootstrap

The initial setup is automated using `bootstrap.sh`.

The script installs the packages required for the lab and prepares the server for future automation.

## Cleanup

Before converting the VM into a template, `cleanup.sh` performs the following tasks:

- Removes temporary files.
- Cleans package caches.
- Clears system logs.
- Removes the current Machine ID.
- Removes existing SSH host keys.

This ensures that cloned machines do not share the same system identity.

## First Boot Initialization

Each cloned VM executes `firstboot.sh` during its first boot.

The script:

- Generates new SSH host keys.
- Creates a unique Machine ID.
- Starts the SSH service.
- Disables itself after successful execution.

This guarantees that every VM has its own unique identity while remaining fully reproducible.

## Validation

The Golden Image was validated by creating multiple cloned virtual machines.

Each clone successfully:

- Generated a unique Machine ID.
- Generated unique SSH host keys.
- Started the SSH service automatically.
- Accepted SSH connections.
- Was renamed with its own hostname.
- Received a static IP address through Netplan.

## Current Infrastructure

| Hostname | Role | IP Address |
|----------|------|------------|
| ansible-control | Automation Node | 192.168.56.10 |
| web01 | Web Server | 192.168.56.11 |
| web02 | Web Server | 192.168.56.12 |
| db01 | Database Server | 192.168.56.13 |

## Lessons Learned

During the creation of the Golden Image, the following concepts were explored:

- Ubuntu Server installation
- VirtualBox cloning
- SSH user keys vs SSH host keys
- Machine IDs
- Systemd services
- Netplan networking
- Static IP configuration
- Passwordless SSH authentication
