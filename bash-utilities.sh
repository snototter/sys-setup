#!/bin/bash --
# Start exporting all following functions
set -a

# Checks if the given package is installed. If yes, returns 0, otherwise 1.
function is_apt_pkg_installed() {
  set +e
  pkg=$1
  if dpkg --get-selections | grep -q "^$pkg\(\|:[^\s]*\)*[[:space:]]*install$" >/dev/null; then
    return 0
  else
    return 1
  fi
}

# Installs a package via apt if it has not been installed yet.
function apt_install {
  is_apt_pkg_installed "$1"
  retval=$?
  if [[ $retval -ne 0 ]]
  then
    echo -e "\e[36;1mInstalling apt package: '$1'\e[0m"
    sudo apt install -y "$@"
    return $?
  else
    echo "Skipping already installed apt package: '$1'"
    return 0
  fi
}

# Installs a package via snap if it has not been installed yet
function snap_install {
  snap list "$1" &> /dev/null

  if [ $? -ne 0 ]
  then
    echo -e "\e[36;1mInstalling snap package: '$1'\e[0m"
    sudo snap install "$@"
    return $?
  else
    echo "Skipping already installed snap package: '$1'"
    return 0
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
  return 0
}

# Adds the APT source if it has not yet been added.
# Usage example:
#   add_apt_source 'deb url ...' some-source.list
function add_apt_source() {
  src=$1
  lst=/etc/apt/sources.list.d/$2
  cnt=$(find /etc/apt/ -name "*.list" | xargs cat | grep -F "$src" | wc -l)
  if [ $cnt -eq 0 ] 
  then
    echo -e "\e[36;1mUpdating APT source $lst\e[0m"
    echo $src | sudo tee $lst >/dev/null
    sudo apt update
  fi
  return 0
}

# Stop exporting
set +a

