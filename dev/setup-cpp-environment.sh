#!/bin/bash --
# Basic build tools
apt_install build-essential
apt_install checkinstall
apt_install ninja-build

# Analysers
apt_install valgrind
apt_install cppcheck # static code analyser
apt_install lcov # gcov extension

#TODO other analysers

# OpenCV
apt_install libopencv-contrib-dev
apt_install libopencv-dev


echo -e "\033[31;1m---------------------------------------------------------------------"
echo "TODO: LLVM cppcheck etc\e[0m"
exit 1

# LLVM (clang-tidy, clang-format)
# via https://apt.llvm.org/
sudo bash -c "$(wget -O - https://apt.llvm.org/llvm.sh)"
sudo apt install -y clang-tidy-15 clang-format-15



#TODO install googletest
