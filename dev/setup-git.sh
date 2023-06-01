#!/bin/bash --

# If invoked manually, this script must be run from the sys-setup root folder
# as it requires the custom "bash-utilities"
set -e # Abort on error
[[ $(type -t apt_install) == function ]] || source ./bash-utilities.sh
set +e

echo
echo
echo -e "\e[36;1m---------------------------------------------------------------------"
echo -e "Installing & configuring git\e[0m"
echo

apt_install git
apt_install gitg
apt_install meld

# TODO set global config as needed

