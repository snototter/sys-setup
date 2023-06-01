#!/bin/bash --

# If invoked manually, this script must be run from the sys-setup root folder
# as it requires the custom "bash-utilities"
set -e # Abort on error
[[ $(type -t apt_install) == function ]] || source ./bash-utilities.sh
set +e

echo
echo
echo -e "\e[36;1m---------------------------------------------------------------------"
echo -e "Installing CMake via kitware's repository\e[0m"
echo


# Adds the kitware repository to ensure we have the latest cmake available
# Workflow adopted from https://apt.kitware.com/
is_apt_pkg_installed "kitware-archive-keyring"
has_kitware_keyring=$?

if [ ${has_kitware_keyring} -ne 0 ]
then
  # Download the signing key:
  wget -O - https://apt.kitware.com/keys/kitware-archive-latest.asc 2>/dev/null | gpg --dearmor - | sudo tee /usr/share/keyrings/kitware-archive-keyring.gpg >/dev/null
  # TODO Whenever their signing key changes, you need to re-download it (rerun command above)
else
  echo -e "\e[36;1mSkipping already installed kitware archive keyring\e[0m"
fi

# TODO This script should be extended once new LTS versions are supported by kitware:
os_version=$(lsb_release -sr)
# OS specific setup:
if [[ $os_version == "22.04" ]]
then
  add_apt_source 'deb [signed-by=/usr/share/keyrings/kitware-archive-keyring.gpg] https://apt.kitware.com/ubuntu/ jammy main' kitware.list
else
  if [[ $os_version == "20.04" ]]
  then
    add_apt_source 'deb [signed-by=/usr/share/keyrings/kitware-archive-keyring.gpg] https://apt.kitware.com/ubuntu/ focal main' kitware.list
  else
    if [[ $os_version == "18.04" ]]
    then
      add_apt_source 'deb [signed-by=/usr/share/keyrings/kitware-archive-keyring.gpg] https://apt.kitware.com/ubuntu/ bionic main' kitware.list
    else
      echo -e "\033[31;1mOS release ${os_version} is not yet supported by the custom cmake installation script!\e0m"
      exit 2
    fi
  fi
fi

if [ ! has_kitware_keyring ]
then
  # Install keyring
  sudo rm -f /usr/share/keyrings/kitware-archive-keyring.gpg
  apt_install kitware-archive-keyring
fi

# Install latest cmake
apt_install cmake

# Install ccmake TUI
apt_install cmake-curses-gui

