#!/usr/bin/env bash

# ==========================================
# Ubuntu Golden Image Cleanup Script
# Prepare VM for cloning
# ==========================================

set -e

echo "Cleaning package cache..."
sudo apt autoremove -y
sudo apt autoclean
sudo apt clean

echo "Removing temporary files..."
sudo rm -rf /tmp/*
sudo rm -rf /var/tmp/*

echo "Cleaning logs..."
sudo journalctl --vacuum-time=1s
sudo find /var/log -type f -exec truncate -s 0 {} \;

echo "Removing machine-id..."
sudo truncate -s 0 /etc/machine-id
sudo rm -f /var/lib/dbus/machine-id

echo "Removing SSH host keys..."
sudo rm -f /etc/ssh/ssh_host_*

echo
echo "========================================="
echo "Golden Image is ready to be cloned."
echo "Shutdown the VM before creating clones."
echo "========================================="