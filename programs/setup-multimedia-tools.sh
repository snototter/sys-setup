#!/bin/bash --

# If invoked manually, this script must be run from the sys-setup root folder
# as it requires the custom "bash-utilities"
set -e # Abort on error
[[ $(type -t apt_install) == function ]] || source ./bash-utilities.sh
set +e

echo
echo
echo -e "\e[36;1m---------------------------------------------------------------------"
echo -e "Installing Image, Video & Audio tools\e[0m"
echo


# Image
apt_install jpegoptim
apt_install optipng
apt_install gimp
apt_install cheese
apt_install geeqie
apt_install imagemagick
apt_install potrace

# Video
apt_install ffmpeg
apt_install vlc

# Audio
apt_install audacity # Audio editor
apt_install audacious

