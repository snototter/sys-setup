#!/bin/bash --
# Basic build tools
sudo apt install -y build-essential checkinstall ninja-build

# Common libraries
sudo apt install -y ffmpeg libavcodec-dev libavformat-dev libavutil-dev libavdevice-dev libswscale-dev libcurl4-openssl-dev libconfig++-dev libeigen3-dev libatlas-base-dev libatlas3-base libcairo2-dev

echo -e "\033[31;1m---------------------------------------------------------------------"
echo "TODO: LLVM cppcheck etc\e[0m"
exit 1

# LLVM (clang-tidy, clang-format)
# via https://apt.llvm.org/
sudo bash -c "$(wget -O - https://apt.llvm.org/llvm.sh)"
sudo apt install -y clang-tidy-15 clang-format-15


# static code analyser: cpp-check
sudo apt install -y cppcheck

# install lcov (gcov) extension
sudo apt install -y lcov

#TODO install googletest
