#!/bin/bash
# Install the neccessary apps and must have items.

command_exists() {
  type "$1" &> /dev/null;
}

# RVM & RUBY
if test ! -x ~/.rvm/bin/rvm; then
  echo "RVM is not installed. starting installation"
  curl -L https://get.rvm.io | bash -s stable --ruby
  [[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
fi

# NVM & NPM
if test ! -d ~/.nvm; then
  echo "NVM is not installed. starting installation"
  curl https://raw.githubusercontent.com/creationix/nvm/v0.7.0/install.sh | sh
  source $HOME/.bash_profile
  nvm install $(curl -s -o - http://nodejs.org/dist/latest/ | grep -oE 'v[0-9]+.[0-9]+.[0-9]+' | sort -u -t . -k 1,1n -k 2,2n -k 3,3)
  sudo chown -R $USER /usr/local
fi

if type npm &> /dev/null; then
  echo "NPM has been installed"
else
  echo "NPM is not installed"
  curl https://www.npmjs.org/install.sh | bash
  exit
fi

# HOMEBREW
if [ "$(uname -s)" == "Darwin" ]; then
  if test ! $(which brew); then
    echo "HOMEBREW is not installed. starting installation"
    ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
  fi
fi

# CONFIGURE SYSTEM
echo "You should add following path to .rc file for using grc. '/usr/local/opt/coreutils/libexec/gnubin:$PATH'"
if [ $(uname -s) == "Darwin" ]; then
  brew install grc coreutils
elif [ "$(uname -s)" == "Linux" ]; then
  apt-get instsall grc coreutils
else
  echo "grc, coreutils skipped install"
fi

# Configure system
if [ "$(uname -s)" == "Linux" ]; then
    sudo chmod -R 755 /usr/local/share/zsh/site-functions
fi

# INSTALL NPM PACKAGES AND GRUNT DOTFILE
if test ! $(npm -g list | grep -oE 'grunt-cli@'); then
  npm install -g grunt-cli
fi

# MAKE DIRECTORY FOR LOCAL FILES IF IT DOESN'T EXISTS
echo "If you want to make symlinks for file in local? Do 'grunt symlink:local after bootstrap'"
if test ! -d ./local; then
  mkdir local
fi

npm install && grunt -v
