#!/bin/bash --
set -e
os_name=$(lsb_release -si)
os_version=$(lsb_release -sr)

# Check OS version
if [[ "Ubuntu" != "${os_name}" || ("22.04" != "${os_version}" && "20.04" != "${os_version}" )]]
then
  echo -e "\033[31;1m---------------------------------------------------------------------"
  echo "Error: Expected Ubuntu 22.04, but current OS is ${os_name} ${os_version}\e[0m"
  exit 1
fi


# Get script directory
src="$BASH_SOURCE[0]"
while [ -h "$src" ]
do # resolve all symlinks
  dname="$( cd -P "$( dirname "${src}" )" >/dev/null 2>&1 && pwd )"
  src="$(readlink "${src}")"
  [[ $src != /* ]] && SOURCE="${dname}/${src}"
done
script_dir="$(cd -P "$( dirname "${src}" )" >/dev/null 2>&1 && pwd)"
# Load custom utilities
source "${script_dir}/bash-utilities.sh"

# Now we can install packages, tools, ...

echo -e "\e[36;1m---------------------------------------------------------------------"
echo -e "Customized setup for ${os_name} ${os_version}\e[0m"

/bin/bash general-utils.sh

echo
echo
echo -e "\e[36;1m---------------------------------------------------------------------"
echo -e "Development tools\e[0m"

/bin/bash dev/setup-basics.sh
/bin/bash dev/setup-cmake.sh
/bin/bash dev/setup-rust.sh
# rust should be installed before setting up git
/bin/bash dev/setup-git.sh
/bin/bash dev/setup-tex-pdf.sh
/bin/bash dev/setup-cpp-environment.sh
/bin/bash dev/setup-python-environment.sh

echo
echo
echo -e "\e[36;1m---------------------------------------------------------------------"
echo -e "Terminal\e[0m"

/bin/bash shell/setup-homebrew.sh
if ! command -v brew &> /dev/null
then
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

/bin/bash shell/setup-zsh.sh
/bin/bash shell/setup-dotfiles.sh


echo
echo
echo -e "\e[36;1m---------------------------------------------------------------------"
echo -e "Disable automatic printer discovery\e[0m"

sudo systemctl stop cups-browsed
sudo systemctl disable cups-browsed

