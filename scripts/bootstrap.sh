#!/usr/bin/env bash

# ==========================================================
# Ubuntu Golden Image Bootstrap Script
# Purpose: Prepare a clean Ubuntu server template
# Author: Med Pro
# ==========================================================

set -e

echo "========================================="
echo " Updating system"
echo "========================================="

sudo apt update
sudo apt upgrade -y

echo "========================================="
echo " Installing common packages"
echo "========================================="

sudo apt install -y \
    curl \
    wget \
    git \
    nano \
    tree \
    htop \
    zip \
    unzip \
    rsync \
    dnsutils \
    net-tools \
    iputils-ping \
    python3 \
    python3-pip \
    python3-venv \
    ca-certificates \
    software-properties-common

echo "========================================="
echo " Cleaning unused packages"
echo "========================================="

sudo apt autoremove -y
sudo apt autoclean

echo "========================================="
echo " Bootstrap completed successfully!"
echo "========================================="