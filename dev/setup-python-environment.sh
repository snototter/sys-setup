#!/bin/bash --

# If invoked manually, this script must be run from the sys-setup root folder
# as it requires the custom "bash-utilities"
set -e # Abort on error
[[ $(type -t apt_install) == function ]] || source ./bash-utilities.sh
set +e

echo
echo
echo -e "\e[36;1m---------------------------------------------------------------------"
echo -e "Installing environment for Python development\e[0m"
echo


echo -e "\033[31;1m---------------------------------------------------------------------"
echo "TODO: Python, venv, conda, etc\e[0m"
exit 1

