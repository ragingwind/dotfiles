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

  export NVM_DIR="$HOME/.nvm" && (
    git clone https://github.com/creationix/nvm.git "$NVM_DIR"
    cd "$NVM_DIR"
    git checkout `git describe --abbrev=0 --tags --match "v[0-9]*" origin`
  ) && . "$NVM_DIR/nvm.sh"

  nvm install --lts
  nvm alias default node
fi

# brew for macOS
if [ "$(uname -s)" == "Darwin" ]; then
  echo "brew will be installed"
  if test ! $(which brew); then
    echo "brew will be installed"
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  fi
fi

# setup node and run scripts
[ -s "$HOME/.nvm/nvm.sh" ] && . "$HOME/.nvm/nvm.sh"
nvm alias default node
npm install && npm start
