#!/bin/bash

set -e

SERVER="$1"

if [ -z "$SERVER" ]; then
    echo "Usage: ./deploy-server.sh <server>"
    exit 1
fi

echo "Checking Ansible connectivity to $SERVER..."

ansible "$SERVER" -m ping

echo "Configuring $SERVER..."

ansible-playbook playbooks/deploy-nginx.yml --limit "$SERVER"

echo "$SERVER configuration completed successfully."