export RVM_DIR="$HOME/.rvm"
# export NVM_DIR="$HOME/.nvm"
export ZSH_DIR="$HOME/.zsh"
export WORKON_HOME="$HOME/.virtualenvs"
export PIP_VIRTUALENV_BASE="$HOME/virtualenvs"

export PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin:$PATH

# ruby
export PATH="$RVM_DIR/bin:$PATH"
[[ -s "$RVM_DIR/scripts/rvm" ]] && source "$RVM_DIR/scripts/rvm"


# python
# source "/usr/local/bin/virtualenvwrapper.sh"

# node.js
# [[ -s "$NVM_DIR/nvm.sh" ]] && . "$NVM_DIR/nvm.sh"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

### heroku toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

# rust
export PATH="$HOME/.cargo/bin:$PATH"

# Go
export GOPATH="$HOME/Go"
