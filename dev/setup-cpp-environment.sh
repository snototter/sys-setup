#!/bin/bash --

# If invoked manually, this script must be run from the sys-setup root folder
# as it requires the custom "bash-utilities"
set -e # Abort on error
[[ $(type -t apt_install) == function ]] || source ./bash-utilities.sh
set +e

echo
echo
echo -e "\e[36;1m---------------------------------------------------------------------"
echo -e "Installing environment for C++ development\e[0m"
echo


# Basic build tools
apt_install build-essential
apt_install checkinstall
apt_install ninja-build


# Analysers
apt_install valgrind
apt_install cppcheck    # static code analyser
apt_install lcov        # gcov extension


# LLVM toolchain (clang-tidy, clang-format, ...)
# https://apt.llvm.org/
is_apt_pkg_installed "clang-tidy-15"
has_clang15=$?

if [ ${has_clang15} -ne 0 ]
then
  echo -e "\e[36;1mInstalling LLVM toolchain\e[0m"
  wget https://apt.llvm.org/llvm.sh
  chmod +x llvm.sh
  sudo ./llvm.sh 15
  rm llvm.sh
else
  echo -e "Skipping already installed LLVM toolchain"
fi


# OpenCV
apt_install libopencv-contrib-dev
apt_install libopencv-dev

