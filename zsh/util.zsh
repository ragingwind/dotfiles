function pserver() { python -m SimpleHTTPServer $@ }
function node_clean() { find . ! -name node_modules -delete }
function subl() {
  /Applications/Sublime\ Text\ 2.app/Contents/SharedSupport/bin/subl $1 &
}

