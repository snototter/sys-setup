#!/bin/bash --

echo
echo
echo -e "\e[36;1m---------------------------------------------------------------------"
echo -e "Installing homebrew\e[0m"
echo

if ! command -v brew &> /dev/null
then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  (echo; echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"') >> $HOME/.zprofile
fi

