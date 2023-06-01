#!/bin/bash --

# If invoked manually, this script must be run from the sys-setup root folder
# as it requires the custom "bash-utilities"
set -e # Abort on error
[[ $(type -t apt_install) == function ]] || source ./bash-utilities.sh


echo
echo
echo -e "\e[36;1m---------------------------------------------------------------------"
echo -e "Installing general dependencies, common libraries & system tools\e[0m"
echo


# Prerequisite packages to add other software sources:
apt_install ca-certificates
apt_install gpg

# General tools & utility packages
apt_install wget
apt_install curl

# File & shell utilities
apt_install file
apt_install htop
apt_install tree
apt_install pv # Monitor progress of data through a pipe
apt_install mlocate

apt_install figlet
apt_install lolcat

# Editors
apt_install vim
apt_install nano

# Network utilities
apt_install nmap
apt_install net-tools
apt_install ssh
apt_install sshfs
apt_install openssh-sftp-server
apt_install cifs-utils
apt_install wireshark

# Archive tools
apt_install unrar
apt_install p7zip
apt_install unzip

# Clipboard tools
apt_install xclip
apt_install xsel

# Misc
apt_install screenruler

# Clean up
sudo apt update -y
sudo apt upgrade -y
sudo apt autoremove -y

