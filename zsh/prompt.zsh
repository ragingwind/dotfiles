# Pure
# by Sindre Sorhus
# https://github.com/sindresorhus/pure
# MIT License

# For my own and others sanity
# git:
# %b => current branch
# %a => current action (rebase/merge)
# prompt:
# %F => color dict
# %f => reset color
# %~ => current path
# %* => time
# %n => username
# %m => shortname host
# %(?..) => prompt conditional - %(condition.true.false)

autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git # You can add hg too if needed: `git hg`
zstyle ':vcs_info:git*' formats ' [%b]'
zstyle ':vcs_info:git*' actionformats ' [%b|%a]'

# enable prompt substitution
setopt PROMPT_SUBST

# can be handy to measure time with accuracy
typeset -F SECONDS=0

# Only show username if not default
local username='%n@%m'

# Fastest possible way to check if repo is dirty
git_dirty() {
  # check if we're in a git repo
  command git rev-parse --is-inside-work-tree &>/dev/null || return
  # check if it's dirty
  command git diff --quiet --ignore-submodules HEAD &>/dev/null; [ $? -eq 1 ] && echo '✎'
}

# Displays the exec time of the last command if set threshold was exceeded
start_time=$SECONDS
cmd_exec_time() {
  printf "%.4fs" "$(($SECONDS-$start_time))"
}

preexec() {
  # echo preexec
  start_time=$SECONDS
}

precmd() {
  # echo precmd
  # Add pwd to z
  _z --add "$(pwd -P)"
  # Check status of virsion control
  vcs_info
  # Add `%*` to display the time
  print -P '\n%F{blue}%~%F{yellow}$vcs_info_msg_0_`git_dirty`%f %F{white}$username%f %F{cyan}`cmd_exec_time`%f'
  # Reset value since `preexec` isn't always triggered
  # unset start_time
  start_time=$SECONDS
}

# Prompt turns red if the previous command didn't exit with 0
PROMPT='%(?.%F{magenta}.%F{red})❯%f '
# Can be disabled:
# PROMPT='%F{magenta}❯%f '