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
  (
    git clone https://github.com/creationix/nvm.git "$NVM_DIR"
    cd "$NVM_DIR"
    git switch `git describe --abbrev=0 --tags --match "v[0-9]*" origin`
  ) && \. "$NVM_DIR/nvm.sh"

  echo '
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
' >> $HOME/.profile

  source $HOME/.profile

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

# Install vim-plug
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
pip3 install pynvim

# Set permission for zsh
sudo chmod -R 755 /usr/local/share/zsh
sudo chown -R root:staff /usr/local/share/zsh
