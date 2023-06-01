#!/bin/bash --

# Adds the kitware repository to ensure we have the latest cmake available
# Workflow adopted from https://apt.kitware.com/
# Download the signing key:
wget -O - https://apt.kitware.com/keys/kitware-archive-latest.asc 2>/dev/null | gpg --dearmor - | sudo tee /usr/share/keyrings/kitware-archive-keyring.gpg >/dev/null
# TODO Whenever their signing key changes, you need to re-download it (rerun command above)
# TODO This script should be extended once new LTS versions are supported by kitware:
osversion=$(cut -f2 <<< $(lsb_release -r))
# OS specific setup:
if [[ $osversion == "22.04" ]]
then
  add_apt_source 'deb [signed-by=/usr/share/keyrings/kitware-archive-keyring.gpg] https://apt.kitware.com/ubuntu/ jammy main' kitware.list
else
  if [[ $osversion == "20.04" ]]
  then
    echo "TODO support 20 & 18! Older OS releases are not yet supported by the cmake installation script!"
    exit 2
  else
    echo "OS release ${osversion} is not yet supported by the cmake installation script!"
    exit 2
  fi
fi

sudo apt-get update
# Install keyring
sudo rm -f /usr/share/keyrings/kitware-archive-keyring.gpg
sudo apt install -y kitware-archive-keyring
# Install latest cmake
sudo apt install -y cmake
# Install ccmake TUI
sudo apt install -y cmake-curses-gui

