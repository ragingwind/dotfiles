#!/bin/sh
# Install the neccessary apps and must have items.

# RVM & RUBY
if test ! $(which ~/.rvm/bin/rvm); then
  echo "RVM is not installed. starting installation"
  curl -L https://get.rvm.io | bash -s stable --ruby
fi

# HOMEBREW
if [ $(uname -s) == "Darwin" ]; then
  if test ! $(which brew); then
    echo "HOMEBREW is not installed. starting installation"
    ruby -e "$(curl -fsSL https://raw.github.com/mxcl/homebrew/go)"
    exit
  fi
fi

# NVM
if test ! $(which ~/.nvm/nvm.sh); then
  echo "NVM is not installed. starting installation"
  curl https://raw.github.com/creationix/nvm/master/install.sh | sh
  nvm install $(curl -s -o - http://nodejs.org/dist/latest/ | grep -oE 'v[0-9]+.[0-9]+.[0-9]+' | sort -u -t . -k 1,1n -k 2,2n -k 3,3)
  sudo chown -R $USER /usr/local
  exit
fi

# MUST HAVE ITEMS
# Grunt is requirement to install dotfile.
if test ! $(npm -g list | grep -oE 'grunt-cli@'); then
  npm install -g grunt-cli
fi

# You should add following path to .rc file for using grc. "/usr/local/opt/coreutils/libexec/gnubin:$PATH"
brew install grc coreutils gibo

# INSTALL NPM PACKAGES AND GRUNT DOTFILE
npm install && grunt