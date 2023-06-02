#!/bin/bash --

# If invoked manually, this script must be run from the sys-setup root folder
# as it requires the custom "bash-utilities"
set -e # Abort on error
[[ $(type -t apt_install) == function ]] || source ./bash-utilities.sh
set +e

apt_install zsh
sudo chsh -s /usr/bin/zsh

# fuzzy finder
brew install fzf
$(brew --prefix)/opt/fzf/install 

# oh-my-zsh basic install
if [ ! -d "$HOME/.oh-my-zsh" ]
then
  echo -e "\e[36;1m---------------------------------------------------------------------"
  echo "Installing oh-my-zsh\e[0m"
  export RUNZSH=no
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  echo -e "\033[31;1m---------------------------------------------------------------------"
  echo "TODO reboot/re-login; if needed replace default shell for user via:\nchsh -s $(which zsh)\e[0m"
  echo "TODO plugins"
else
  echo -e "\e[36;1mSkipping oh-my-zsh installation\e[0m"
fi

# Font installation for p10k
if ls ~/.local/share/fonts/MesloLGS*ttf 1> /dev/null 2>&1
then
  echo -e "\e[36;1mSkipping p10k font installation\e[0m"
else
  echo -e "\e[36;1mInstalling MesloLGS font for p10k\e[0m"
  # Download font, move to users font directory & reload the font cache
  wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf
  wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf
  wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf
  wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf
  mkdir -p ~/.local/share/fonts/
  mv Meslo*.ttf ~/.local/share/fonts/
  fc-cache -f -v
  
  echo -e "\e[36;1mLoading custom gnome-terminal profile\e[0m"
  scriptdir=$(rec_resolve_dir ${BASH_SOURCE[0]})
  dconf load /org/gnome/terminal/legacy/profiles:/ < "$scriptdir/../data/gnome-terminal-profiles.dconf"
  # echo "Open 'Terminal → Preferences' and click on the selected profile under 'Profiles'."
  # echo "Check 'Custom font' under 'Text Appearance' and select 'MesloLGS NF Regular'."
fi

# p10k installation
dst="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
if [ -d "$dst" ]
then
  echo -e "\e[36;1mSkipping p10k installation\e[0m"
else
  echo -e "\e[36;1mInstalling p10k\e[0m"
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $dst
  # ZSH_THEME is set via my dotfiles
  # manual: SET ZSH_THEME="powerlevel10k/powerlevel10k" in .zshrc
fi

# autosuggestions
dst=${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
if [ -d "$dst" ]
then
  echo -e "\e[36;1mSkipping zsh-autosuggestions installation\e[0m"
else
  echo -e "\e[36;1mInstalling zsh-autosuggestions\e[0m"
  git clone https://github.com/zsh-users/zsh-autosuggestions $dst
  # This plugin is included in my .zshrc via dotfiles
fi

# syntax highlighting
dst=${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
if [ -d "$dst" ]
then
  echo -e "\e[36;1mSkipping zsh-syntax-highlighting installation\e[0m"
else
  echo -e "\e[36;1mInstalling zsh-syntax-highlighting\e[0m"
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $dst
  # This plugin is included in my .zshrc via dotfiles
fi


