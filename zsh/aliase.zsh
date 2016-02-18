# ZSH
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
alias rd=rmdir
alias d='dirs -v | head -10'

# LIST DIRECORY CONTENTS
alias lsa='ls -lah'
alias l='ls -lA1'
alias ll='ls -l'
alias la='ls -lA'
alias sl=ls # often screw this up

alias treed='tree -d -L 1'
alias treed2='tree -d -L 2'
