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


apt_install python3-pip
apt_install python3-venv
apt_install python3-dev
apt_install python3-ipython
apt_install python3-numpy
apt_install python3-opencv
apt_install python3-tk
apt_install python3-wheel

/usr/bin/python3 -m pip install --upgrade pip

add_apt_repository deadsnakes ppa
# Check available versions for distributions and select, which ones should be
# installed: https://launchpad.net/~deadsnakes/+archive/ubuntu/ppa
os_version=$(lsb_release -sr)
case $os_version in
  "22.04" | "20.04")
    py_versions=("3.8" "3.11")
    ;;
    
  "18.04")
    py_versions=("3.8")
    ;;
    
  *)
    echo -e "\033[31;1mOS release ${os_version} is not yet supported by the custom cmake installation script!\e0m"
    exit 2
    ;;
esac

for pyver in ${py_versions[@]}
do
  echo -e "\e[36;1mInstalling additional Python ${pyver}\e[0m"
  
  apt_install python${pyver}
  apt_install python${pyver}-dev
  apt_install python${pyver}-tk
  apt_install python${pyver}-venv
done

echo -e "\033[31;1m---------------------------------------------------------------------"
echo "TODO: conda, etc\e[0m"
exit 1

