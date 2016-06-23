# Functions for macOS

ftp() {
  if [ "$1" == "on" ]; then
    sudo -s launchctl load -w /System/Library/LaunchDaemons/ftp.plist
    echo "FTP server is runnung"
  else
    sudo -s launchctl unload -w /System/Library/LaunchDaemons/ftp.plist
    echo "FTP server has been stopped"
  fi
}
