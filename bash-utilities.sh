#!/bin/bash --

# Installs a package via apt if it has not been installed yet.
function apt_install {
  pkg_installed=$((dpkg-query -W --showformat='${Status}\n' "$1" | grep "install ok installed") 2> /dev/null)

  if [ "" = "$pkg_installed" ]
  then
    echo -e "\e[36;1mInstalling apt package: '$1'\e[0m"
    sudo apt install -y "$@"
  else
    echo -e "\e[36;1mSkipping already installed apt package: '$1'\e[0m"
  fi
}

# Installs a package via snap if it has not been installed yet
function snap_install {
  snap list "$1" &> /dev/null

  if [ $? -ne 0 ]
  then
    echo -e "\e[36;1mInstalling snap package: '$1'\e[0m"
    sudo snap install "$@"
  else
    echo -e "\e[36;1mSkipping already installed snap package: '$1'\e[0m"
  fi
}

# Recursively resolves the given directory.
# Taken from https://stackoverflow.com/a/246128/400948
#
# Useful to resolve the path of a bash script:
#   scriptdir=$(rec_resolve_dir ${BASH_SOURCE[0]})
# zsh equivalent to bash_source[0]: ${(%):-%x}
#   (see https://stackoverflow.com/a/28336473/400948)
function rec_resolve_dir {
  src="$1"
  while [ -h "$src" ]; do # resolve $src until the file is no longer a symlink
      dname="$( cd -P "$( dirname "${src}" )" >/dev/null 2>&1 && pwd )"
      src="$(readlink "${src}")"
      # if $src was a relative symlink, we need to resolve it relative to the path where the symlink file was located
      [[ $src != /* ]] && SOURCE="${dname}/${src}"
  done
  resdir="$(cd -P "$( dirname "${src}" )" >/dev/null 2>&1 && pwd)"
  echo "${resdir}"
}
