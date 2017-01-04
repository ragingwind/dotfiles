#!/bin/bash

# rvm and ruby stable version
if test ! -d ~/.rvm; then
  echo "rvm and ruby stable version will be installed"
  curl -sSL https://get.rvm.io | bash -s stable --ruby
  [[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
fi

# nvm & node.js stable version
if test ! -d ~/.nvm; then
  echo "nvm and node.js lts version will be installed"
  curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.0/install.sh | bash
  [ -s "$HOME/.nvm/nvm.sh" ] && . "$HOME/.nvm/nvm.sh"
  nvm install --lts
  nvm alias default node
fi

# brew
if [ "$(uname -s)" == "Darwin" ]; then
  if test ! $(which brew); then
    echo "brew will be installed"
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  fi

  # install shell-bin not existing on macOS
  brew install tree

  # install and change shell into zsh
  brew install zsh
  brew install tmux

  # update macos environment
  source .macos
fi

# configuration for linux
if [ "$(uname -s)" == "Linux" ]; then
  sudo chown -R $USER /usr/local/lib/node_modules
  sudo chown -R $USER /usr/local/share
  sudo chown -R $USER /usr/local/bin
  sudo chmod -R 755 /usr/local/share/zsh/site-functions
  sudo chown -R root /usr/local/share/zsh/site-functions
fi

# setup node and excute install script
[ -s "$HOME/.nvm/nvm.sh" ] && . "$HOME/.nvm/nvm.sh"
nvm alias default node
npm install && npm start

