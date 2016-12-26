
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

# INSTANT SERVER
pserver() {
  python -m SimpleHTTPServer $@
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

# DIFF
function diff {
    colordiff -u "$@" | less -RF
}

# VS CODE
code () {VSCODE_CWD="$PWD" open -n -b "com.microsoft.VSCode" --args $* ;}
