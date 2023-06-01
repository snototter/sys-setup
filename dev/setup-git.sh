#!/bin/bash --

# If invoked manually, this script must be run from the sys-setup root folder
# as it requires the custom "bash-utilities"
set -e # Abort on error
[[ $(type -t apt_install) == function ]] || source ./bash-utilities.sh
set +e

echo
echo
echo -e "\e[36;1m---------------------------------------------------------------------"
echo -e "Installing & configuring git\e[0m"
echo

apt_install git
apt_install gitg
apt_install meld

# Barplot for terminal, used by git-heatmap
cargo install --git https://github.com/jez/barchart.git
# Install git-heatmap
wget -O git-heatmap https://raw.githubusercontent.com/jez/git-heatmap/master/git-heatmap
sudo mv git-heatmap /usr/local/bin
sudo chmod a+x /usr/local/bin/git-heatmap

# TODO set global config as needed

