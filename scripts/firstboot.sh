# paste this in `sudo nano /usr/local/bin/firstboot.sh`

#!/usr/bin/env bash

set -e

echo "Running first boot initialization..."

# Generate SSH host keys if missing
ssh-keygen -A

# Generate a new machine-id if missing
systemd-machine-id-setup

# Enable and start SSH
systemctl reset-failed ssh || true
systemctl enable ssh
systemctl start ssh

echo "First boot initialization complete."

# Disable this service forever
systemctl disable firstboot.service
rm -f /etc/systemd/system/firstboot.service

exit 0