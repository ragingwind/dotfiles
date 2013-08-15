[[ -s /Users/ragingwind/.nvm/nvm.sh ]] && . /Users/ragingwind/.nvm/nvm.sh  # This loads NVM

NPM_PACKAGES="~/.npm-packages"
NODE_PATH="$NPM_PACKAGES/lib/node_modules:$NODE_PATH"
export PATH="$NPM_PACKAGES/bin:$HOME/.nvm:$PATH"
unset MANPATH  # delete if you already modified MANPATH elsewhere in your config
MANPATH="$NPM_PACKAGES/share/man:$(manpath)"