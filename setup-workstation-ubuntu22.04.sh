#!/bin/bash --
set -e
os_name=$(lsb_release -si)
os_version=$(lsb_release -sr)

if [[ "Ubuntu" != "${os_name}" || "22.04" != "${os_version}" ]]
then
  echo -e "\033[31;1m---------------------------------------------------------------------"
  echo "Error: Expected Ubuntu 22.04, but current OS is ${os_name} ${os_version}\e[0m"
  exit 1
fi


echo -e "\e[36;1m---------------------------------------------------------------------"
echo -e "Customized setup for ${os_name} ${os_version}\e[0m"

/bin/bash general-utils.sh


echo
echo
echo -e "\e[36;1m---------------------------------------------------------------------"
echo -e "Development tools\e[0m"

/bin/bash dev/setup-cmake.sh
/bin/bash dev/setup-git.sh


echo
echo
echo -e "\e[36;1m---------------------------------------------------------------------"
echo -e "Terminal\e[0m"

/bin/bash shell/setup-zsh.sh
/bin/bash shell/setup-dotfiles.sh

