#!/bin/bash --

# If invoked manually, this script must be run from the sys-setup root folder
# as it requires the custom "bash-utilities"
set -e # Abort on error
[[ $(type -t apt_install) == function ]] || source ./bash-utilities.sh
set +e

echo
echo
echo -e "\e[36;1m---------------------------------------------------------------------"
echo -e "Installing LaTeX & PDF tools\e[0m"
echo

# LaTeX
apt_install texlive-full
apt_install kile # TODO configuration - manual vs dotfile (Settings > Configure Kile > Tools > Build > ViewPDF -- set okular as default viewer

# PDF Viewer
apt_install okular
apt_install phonon4qt5-backend-vlc # Let okular play embedded media

# PDF tools
apt_install pdftk
#TODO set up aliases for pdfnup pdfrotate etc

