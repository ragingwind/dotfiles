# -----------------------------------------------------------------------------
# zsh configs
# -----------------------------------------------------------------------------

# GREP RESULTS COLOR, EXAMPLES: http://rubyurl.com/ZXv
export GREP_OPTIONS='--color=auto'
export GREP_COLOR='1;32'

# LS COLOR
export LSCOLORS="exfxcxdxbxegedabagacad"
export CLICOLOR=true

# HISTORY
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

# OPTIONS
setopt NO_BG_NICE
setopt NO_HUP
setopt NO_LIST_BEEP
setopt LOCAL_OPTIONS
setopt LOCAL_TRAPS
setopt HIST_VERIFY
# setopt SHARE_HISTORY
setopt EXTENDED_HISTORY
setopt PROMPT_SUBST
setopt CORRECT
setopt COMPLETE_IN_WORD
setopt IGNORE_EOF
setopt APPEND_HISTORY
# setopt INC_APPEND_HISTORY SHARE_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_REDUCE_BLANKS
setopt auto_name_dirs
setopt auto_pushd
setopt pushd_ignore_dups
setopt complete_aliases

# Reclaim CTRL-S and CTRL-Q key bindings
stty -ixon -ixoff

#bindkey '^[[1;5D' backward-word
#"bindkey '^[[1;5C' forward-word

# -----------------------------------------------------------------------------
# zsh aliase
# -----------------------------------------------------------------------------

alias re!='source ~/.zshrc'

# IP ADDRESSES
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
alias localip="ipconfig getifaddr en1"
alias ips="ifconfig -a | perl -nle'/(\d+\.\d+\.\d+\.\d+)/ && print $1'"
alias lip="ifconfig | grep 192"

# ENHANCED WHOIS LOOKUPS
alias whois="whois -h whois-servers.net"

# SHOW HISTORY
alias history='fc -l 1'

# BASIC DIRECTORY OPERATIONS
alias ..='cd ..'
alias ...='cd ../..'
alias cd..='cd ..'
alias cd...='cd ../..'
alias cd....='cd ../../..'
alias cd.....='cd ../../../..'
alias cd/='cd /'
alias -- -='cd -'

alias 1='cd -'
alias 2='cd +2'
alias 3='cd +3'
alias 4='cd +4'
alias 5='cd +5'
alias 6='cd +6'
alias 7='cd +7'
alias 8='cd +8'
alias 9='cd +9'

alias md='mkdir -p'
alias rd='rm -rf'
alias d='dirs -v | head -10'

# LIST DIRECORY CONTENTS
alias lsa='ls -lah'
alias l='ls -lA1'
alias ll='ls -l'
alias la='ls -lA'
alias sl=ls # often screw this up

# tree
alias tree1='tree -L 1'
alias tree2='tree -L 2'
alias treed='tree -d -L 1'
alias treed2='tree -d -L 2'

#touch
alias tc='touch'
alias t='touch'
alias mf='touch'

# DIRECTORY
mkcd() { mkdir -p "$@" && cd "$_"; }

cd () {
  if   [[ "x$*" == "x..." ]]; then
    cd ../..
  elif [[ "x$*" == "x...." ]]; then
    cd ../../..
  elif [[ "x$*" == "x....." ]]; then
    cd ../../../..
  elif [[ "x$*" == "x......" ]]; then
    cd ../../../../..
  else
    builtin cd "$@"
  fi
}

se() {
  find . -type f -print | xargs grep -i "$1" /dev/null
}

# INSTANT SERVER
pserver() {
  python3 -m http.server
}

# NODE
node_clean() {
  find . ! -name node_modules -delete
}

# SUBLIME
subl() {
  # DEPRECATED
  # /Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl $1 &
  open -a 'Sublime Text' $1
}

rmpyc() {
  find . -name "*.pyc" -exec rm -rf {} \;
}

lss() {
  ls -a $1| sort
}

lsz() {
	ls -lah $1 | awk '{print $9, $5}' | column -t
}

# DIFF
function diff {
    colordiff -u "$@" | less -RF
}

di() {
  query=$(echo $1 | iconv -f utf-8 -t euc-kr)
  curl -s -G -H "Content-Type: text/html; charset=euc-kr" 'http://dic.impact.pe.kr/ecmaster-cgi/search.cgi?bool=and&word=yes' \
    --data-urlencode "kwd=$query" > $TMPDIR/index.html && open $TMPDIR/index.html
}

# -----------------------------------------------------------------------------
# zsh completion
# -----------------------------------------------------------------------------

# matches case insensitive for lowercase
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# pasting with tabs doesn't perform completion
zstyle ':completion:*' insert-tab pending

zmodload zsh/zprof
