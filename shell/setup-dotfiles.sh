#!/bin/bash --

echo
echo
echo -e "\e[36;1m---------------------------------------------------------------------"
echo -e "Setting up my personalized dotfiles\e[0m"

# Prevent potential recursion issues
grep -Fxq ".dotcfg" "$HOME/.gitignore"
retval=$?
if [ $retval -ne 0 ]
then
  echo ".dotcfg" >> $HOME/.gitignore
fi

# Set up the (local) alias
shopt -s expand_aliases
alias dotconfig='/usr/bin/git --git-dir=$HOME/.dotcfg/ --work-tree=$HOME'

# Clone the bare repository
if [ ! -d "$HOME/.dotcfg" ]
then
  git clone --bare git@github.com:snototter/dotfiles.git $HOME/.dotcfg
    # Hide untracked files
  dotconfig config --local status.showUntrackedFiles no
  # User details
  dotconfig config --local user.name "snototter"
  dotconfig config --local user.email "snototter@users.noreply.github.com"
  # Set upstream branch
  dotconfig push --set-upstream origin main
fi


backup_dotdir=$HOME/.dotfile-backup
backup_dotfile() {
  dotfile=$1
  backupdir=$2
  pth=$(dirname $dotfile)
  if [ "$pth" != "." ]
  then
    mkdir -p $backupdir/$pth
    retval=$?
    if [[ retval -ne 0 ]]
    then
      echo -e "\033[31;1mCould not create backup dir: '$backupdir/$pth'! Aborting now.\e[0m"
      exit 1
    fi
  fi
  src=$HOME/$dotfile
  dst=$backupdir/$dotfile
  echo -e "\e[36;1mdotfile setup will replace '$src', backing it up to:\n    '$dst'.\e[0m"
  mv $src $dst
  return $?
}

export -f backup_dotfile

export backup_dotdir=$backup_dotdir

mkdir -p $backup_dotdir && \
  dotconfig checkout 2>&1 | egrep "^\s+[[:alnum:]\.]" | awk {'print $1'} | \
  xargs -I{} /bin/bash -c 'backup_dotfile "$@" "$backup_dotdir"' _ {}

if [ -n "$(ls -A $backup_dotdir 2> /dev/null)" ]
then
  echo -e "\033[31;1mWarning: dotfile setup had to backup files at:\n    ${backup_dotdir}\n\nCheck the backup manually!\n\e[0m"
  echo -e "\e[36;1mRerunning dotfile checkout now.\e[0m"
  dotconfig checkout || exit 2
else
  # Succeeded, unlink the backup directory
  rmdir $backupdir
fi
echo -e "\e[36;1mdotfile setup suceeded.\e[0m"

