#!/bin/bash

# target path
export RVM_DIR="$HOME/.rvm"
export NVM_DIR="$HOME/.nvm"

# rvm and ruby stable version
if test ! -d ~/.rvm; then
  curl -sSL https://get.rvm.io | bash -s stable --ruby
  [[ -s "$RVM_DIR/scripts/rvm" ]] && source "$RVM_DIR/scripts/rvm"
fi

# nvm & node.js stable version
if test ! -d ~/.nvm; then
  git clone https://github.com/creationix/nvm.git "$NVM_DIR"
  cd "$NVM_DIR"
  git checkout `git describe --abbrev=0 --tags --match "v[0-9]*" origin`
  [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
  cd -

  # install node lts version as default
  nvm install --lts
  nvm alias default node

  # install yarn to make its as default package manager
  npm install -g yarn

  # install essential setting tools
  npm install -g @moonandyou/symlinks-cli
fi

# brew for macOS
if [ "$(uname -s)" == "Darwin" ]; then
  if test ! $(which brew); then
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  fi

  brew tap homebrew/bundle
  brew bundle
fi

# change shell
chsh -s $(which zsh)
