#!/bin/bash
# Install the neccessary apps and must have items.

command_exists() {
  type "$1" &> /dev/null;
}

# RVM & RUBY
if test ! -x ~/.rvm/bin/rvm; then
  echo "RVM is not installed. starting installation"
  curl -L https://get.rvm.io | bash -s stable --ruby
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
    ruby -e "$(curl -fsSL https://raw.github.com/mxcl/homebrew/go)"
  fi
fi

# MUST HAVE ITEMS
# Grunt is requirement to install dotfile.
if test ! $(npm -g list | grep -oE 'grunt-cli@'); then
  npm install -g grunt-cli
fi

# Dropbox
curl 'https://linux.dropbox.com/packages/dropbox.py' > /usr/local/bin/dropbox.py
chmod 755 /usr/local/bin/dropbox.py

# You should add following path to .rc file for using grc. "/usr/local/opt/coreutils/libexec/gnubin:$PATH"
if [ $(uname -s) == "Darwin" ]; then
  brew install grc coreutils gibo
else
  apt-get instsall grc coreutils
  curl https://raw.github.com/simonwhitaker/gitignore-boilerplates/master/gibo \
    -o /usr/local/bin/gibo && sudo chmod +x /usr/local/bin/gibo && gibo -u
fi

# Configure system
if [ "$(uname -s)" == "Linux" ]; then
    sudo chmod -R 755 /usr/local/share/zsh/site-functions
fi

# INSTALL NPM PACKAGES AND GRUNT DOTFILE
npm install && grunt -v
