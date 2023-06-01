#!/bin/bash --

echo
echo
echo -e "\e[36;1m---------------------------------------------------------------------"
echo -e "Installing general dependencies, common libraries & system tools\e[0m"

# Prerequisite packages to add other software sources:
sudo apt update
sudo apt install -y ca-certificates gpg wget

# General tools & utility packages
sudo apt install -y curl

# Network utilities:
sudo apt install -y ssh sshfs openssh-sftp-server net-tools cifs-utils

# Archive tools
sudo apt install -y unrar p7zip

