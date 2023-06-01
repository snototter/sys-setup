#!/bin/bash --

# If invoked manually, this script must be run from the sys-setup root folder
# as it requires the custom "bash-utilities"
set -e # Abort on error
[[ $(type -t apt_install) == function ]] || source ./bash-utilities.sh
set +e

echo
echo
echo -e "\e[36;1m---------------------------------------------------------------------"
echo -e "Installing basic tools & libraries for software development\e[0m"
echo

# Common tools
apt_install checkinstall
apt_install ffmpeg
apt_install jq # JSON parser

# Common libraries & tools
apt_install libatlas-base-dev
apt_install libatlas3-base 
apt_install libavcodec-dev
apt_install libavdevice-dev
apt_install libavformat-dev
apt_install libavutil-dev
apt_install libblas-dev
apt_install libcairo2-dev
apt_install libconfig++-dev
apt_install libcurl4-openssl-dev
apt_install libeigen3-dev
apt_install libflann-dev
apt_install libfreeimage-dev
apt_install libjpeg-dev
apt_install liblapack-dev
apt_install libopenblas-base
apt_install libopenblas-dev
apt_install libpcl-dev
apt_install libpng-dev
apt_install libprotobuf-dev
apt_install libswscale-dev
