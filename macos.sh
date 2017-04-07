#!/usr/bin/env bash

# inspired from https://mths.be/macos

# -----------------------------------------------------------------------------
# setup
# -----------------------------------------------------------------------------

# close any open System Preferences panes, to prevent them from overriding
osascript -e 'tell application "System Preferences" to quit'

# ask for the administrator password upfront
sudo -v

# keep-alive; update existing `sudo` time stamp until `.macos` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# -----------------------------------------------------------------------------
# system
# -----------------------------------------------------------------------------

# disable the sound effects on boot
sudo nvram SystemAudioVolume=" "

# disable the sudden motion sensor as it’s not useful for SSDs
sudo pmset -a sms 0

# disable hibernation (speeds up entering sleep mode)
sudo pmset -a hibernatemode 0

# remove the sleep image file to save disk space
sudo rm /private/var/vm/sleepimage
sudo touch /private/var/vm/sleepimage
sudo chflags uchg /private/var/vm/sleepimage

# -----------------------------------------------------------------------------
# env, shell and global ui/ux
# -----------------------------------------------------------------------------

# env: change computer name
sudo scutil --set ComputerName $USER
sudo scutil --set ComputerName $USER
sudo scutil --set HostName $USER
sudo scutil --set LocalHostName $USER
sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string $USER

# env: set language and text formats
defaults write NSGlobalDomain AppleLanguages -array "en-US" "ko-US"

# env: set locale and currency
defaults write NSGlobalDomain AppleLocale -string "en_KR@currency=KRW"

# env: set measurement units to matric
defaults write NSGlobalDomain AppleMetricUnits -int 1

# env: set highlight color to contessa color
defaults write NSGlobalDomain AppleHighlightColor -string "1 0.78 0.78"

# shell: disable automatic termination of inactive apps
defaults write NSGlobalDomain NSDisableAutomaticTermination -bool true

# shell: disable the crash reporter
defaults write com.apple.CrashReporter DialogType -string "none"

# shell: change path of captured images
defaults write com.apple.screencapture location -string "~/Downloads"

# shell: get out shadows of captured images
defaults write com.apple.screencapture disable-shadow -bool true

# ui/ux: set sidebar icon size to medium
defaults write NSGlobalDomain NSTableViewDefaultSizeMode -int 2

# ui/ux: hide all of files on desktop
defaults write com.apple.finder CreateDesktop -bool false

# ui/ux: expanded save panel by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true

# ui/ux: expand print panel by default
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true

# ui/ux: disable the “are you sure you want to open this application?” dialog
defaults write com.apple.LaunchServices LSQuarantine -bool false

# ui/ux: remove duplicates in the “Open With” menu (also see `lscleanup` alias)
/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user

# ui/ux: disable resume/re-open system-wide
defaults write com.apple.systempreferences NSQuitAlwaysKeepsWindows -bool false

# ui/ux: automatically quit printer app once the print jobs complete
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

# ui/ux: disable smart quotes as they’re annoying when typing code
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false

# ui/ux: don't use scroll gesture with the Ctrl (^) modifier key to zoom
defaults write com.apple.universalaccess closeViewScrollWheelToggle -bool false
defaults write com.apple.universalaccess HIDScrollZoomModifierMask -int 262144

# ui/ux: follow the keyboard focus while zoomed in
defaults write com.apple.universalaccess closeViewZoomFollowsFocus -bool false

# ui/ux: always show scrollbars, values: `WhenScrolling`, `Automatic` and `Always`
defaults write NSGlobalDomain AppleShowScrollBars -string "Automatic"

# ui/ux: disable the over-the-top focus ring animation
defaults write NSGlobalDomain NSUseAnimatedFocusRing -bool false

# ui/ux: increase window resize speed for cocoa applications
defaults write NSGlobalDomain NSWindowResizeTime -float 0.001

# ui/ux: menu bar load items
defaults write com.apple.systemuiserver menuExtras -array \
	"/System/Library/CoreServices/Menu Extras/Bluetooth.menu" \
	"/System/Library/CoreServices/Menu Extras/Battery.menu" \
	"/System/Library/CoreServices/Menu Extras/Clock.menu"

# trackpad: enable tap to click for this user and for the login screen
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# trackpad: map bottom right corner to right-click
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpadioCornerSecondaryClick -int 2
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadRightClick -bool true
defaults -currentHost write NSGlobalDomain com.apple.trackpad.trackpadCornerClickBehavior -int 1
defaults -currentHost write NSGlobalDomain com.apple.trackpad.enableSecondaryClick -bool true

# trackpad: disable “natural” (lion-style) scrolling
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false

# bluetooth: increase sound quality for Bluetooth headphones/headsets
defaults write com.apple.BluetoothAudioAgent "Apple Bitpool Min (editable)" -int 40

# keyboard: disable smart dashes as they’re annoying when typing code
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

# keyboard: enable full keyboard access for all controls
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

# keyboard: disable press-and-hold for keys in favor of key repeat
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

# keyboard: set key repeat
defaults write NSGlobalDomain KeyRepeat -int 1

# keyboard: set initial key repeat
defaults write NSGlobalDomain InitialKeyRepeat -int 13

# keyboard: disable auto-correct
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

# datetime: set the timezone; see `sudo systemsetup -listtimezones` for other values
sudo systemsetup -settimezone "Asia/Seoul" > /dev/null

# sound
defaults write .GlobalPreferences com.apple.sound.beep.volume -float 0.0

# -----------------------------------------------------------------------------
# finder and bundled apps
# -----------------------------------------------------------------------------

# finder: allow quitting via ⌘ + Q; doing so will also hide desktop icons
defaults write com.apple.finder QuitMenuItem -bool true

# finder: disable window animations and get Info animations
defaults write com.apple.finder DisableAllAnimations -bool true

# finder: set download as the default location for new finder
# for other paths, use `PfLo` and `file:///full/path/here/`
defaults write com.apple.finder NewWindowTarget -string "PfLo"
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/Downloads/"

# finder: show icons for hard drives, servers, and removable media on the desktop
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowMountedServersOnDesktop -bool true
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true

# finder: show hidden files by default
defaults write com.apple.finder AppleShowAllFiles -bool true

# finder: show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# finder: show status bar at bottom
defaults write com.apple.finder ShowStatusBar -bool true

# finder: show path bar at bottom
defaults write com.apple.finder ShowPathbar -bool false

# finder: display full path on top of finder window as posix style
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

# finder: keep folders on top when sorting by name
defaults write com.apple.finder _FXSortFoldersFirst -bool true

# finder: when performing a search, search the current folder by default
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# finder: disable the warning when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# finder: avoid creating .DS_Store files on network or USB volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# finder: disable disk image verification
defaults write com.apple.frameworks.diskimages skip-verify -bool true
defaults write com.apple.frameworks.diskimages skip-verify-locked -bool true
defaults write com.apple.frameworks.diskimages skip-verify-remote -bool true

# finder: automatically open a new finder window when a volume is mounted
defaults write com.apple.frameworks.diskimages auto-open-ro-root -bool true
defaults write com.apple.frameworks.diskimages auto-open-rw-root -bool true
defaults write com.apple.finder OpenWindowForNewRemovableDisk -bool true

# finder: Use list view in all Finder windows by default
# for the other view modes: `icnv`, `clmv`, `Flwv`
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

# finder: disable the warning before emptying the Trash
defaults write com.apple.finder WarnOnEmptyTrash -bool false

# finder: show the ~/Library folder
chflags nohidden ~/Library

# fidner: show the /Volumes folder
sudo chflags nohidden /Volumes

# finder: expand the following file Info panes:
# “General”, “Open with”, and “Sharing & Permissions”
defaults write com.apple.finder FXInfoPanesExpanded -dict \
	General -bool true \
	OpenWith -bool true \
	Privileges -bool true

# activity-monitor: show the main window
defaults write com.apple.ActivityMonitor OpenMainWindow -bool true

# activity-monitor: visualize cpu usage in the activity monitor dock icon
defaults write com.apple.ActivityMonitor IconType -int 3

# activity-monitor: show all processes
defaults write com.apple.ActivityMonitor ShowCategory -int 0

# activity-monitor: sort activity monitor results by cpu usage
defaults write com.apple.ActivityMonitor SortColumn -string "CPUUsage"
defaults write com.apple.ActivityMonitor SortDirection -int 0

# itunes: stop itunes from responding to the keyboard media keys
launchctl unload -w /System/Library/LaunchAgents/com.apple.rcd.plist 2> /dev/null

# dock: set the icon size of Dock items to 36 pixels
defaults write com.apple.dock tilesize -int 36

# dock: change minimize/maximize window effect
defaults write com.apple.dock mineffect -string "scale"

# dock: minimize windows into their application’s icon
defaults write com.apple.dock minimize-to-application -bool true

# dock: enable spring loading for all dock items
defaults write com.apple.dock enable-spring-load-actions-on-all-items -bool true

# dock: show indicator lights for open applications in the dock
defaults write com.apple.dock show-process-indicators -bool true

# dock: wipe all (default) app icons from the dock. warn: only for new macos
defaults write com.apple.dock persistent-apps -array

# dock: show only open applications in the Dock
defaults write com.apple.dock static-only -bool true

# dock: don’t animate opening applications from the Dock
defaults write com.apple.dock launchanim -bool false

# mission-control: speed up animations
defaults write com.apple.dock expose-animation-duration -float 0.1

# mission-control: don’t group windows by application
defaults write com.apple.dock expose-group-by-app -bool false

# mission-control: disable dashboard
defaults write com.apple.dashboard mcx-disabled -bool true
defaults write com.apple.dock dashboard-in-overlay -bool true

# dock: don’t automatically rearrange spaces based on most recent use
defaults write com.apple.dock mru-spaces -bool false

# dock: remove the auto-hiding dock delay
defaults write com.apple.dock autohide-delay -float 0

# dock: remove the animation when hiding/showing the dock
defaults write com.apple.dock autohide-time-modifier -float 0

# dock: automatically hide and show the dock
defaults write com.apple.dock autohide -bool true

# dock: make dock icons of hidden applications translucent
defaults write com.apple.dock showhidden -bool true

# launchpad: enable the gesture (pinch with thumb and three fingers)
defaults write com.apple.dock showLaunchpadGestureEnabled -int 1

# launchpad: reset launchpad, but keep the desktop wallpaper intact
find "${HOME}/Library/Application Support/Dock" -name "*-*.db" -maxdepth 1 -delete

# textedit: use plain text mode for new textedit documents
defaults write com.apple.TextEdit RichText -int 0

# textedit: open and save files as utf-8 in textedit
defaults write com.apple.TextEdit PlainTextEncoding -int 4
defaults write com.apple.TextEdit PlainTextEncodingForWrite -int 4

# disk-utility: enable the debug menu
defaults write com.apple.DiskUtility DUDebugMenuEnabled -bool true
defaults write com.apple.DiskUtility advanced-image-options -bool true

# mas: enable the webKit developer tools in the mac app store
defaults write com.apple.appstore WebKitDeveloperExtras -bool true

# mas: enable debug menu in the mac app store
defaults write com.apple.appstore ShowDebugMenu -bool true

# mas: disable the automatic update check
defaults write com.apple.SoftwareUpdate AutomaticCheckEnabled -bool false

# safari: privacy: don’t send search queries to apple
defaults write com.apple.Safari UniversalSearchEnabled -bool false
defaults write com.apple.Safari SuppressSearchSuggestions -bool true

# safari: press tab to highlight each item on a web page
defaults write com.apple.Safari WebKitTabToLinksPreferenceKey -bool true
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2TabsToLinks -bool true

# safari: show the full url in the address bar (note: this still hides the scheme)
defaults write com.apple.Safari ShowFullURLInSmartSearchField -bool true

# safari: set safari’s home page to `about:blank` for faster loading
defaults write com.apple.Safari HomePage -string "about:blank"

# safari: prevent safari from opening ‘safe’ files automatically after downloading
defaults write com.apple.Safari AutoOpenSafeDownloads -bool false

# safari: hide safari’s bookmarks bar by default
defaults write com.apple.Safari ShowFavoritesBar -bool false

# safari: hide safari’s sidebar in top sites
defaults write com.apple.Safari ShowSidebarInTopSites -bool false

# safari: disable safari’s thumbnail cache for history and top sites
defaults write com.apple.Safari DebugSnapshotsUpdatePolicy -int 2

# safari: enable safari’s debug menu
defaults write com.apple.Safari IncludeInternalDebugMenu -bool true

# safari: make safari’s search banners default to contains instead of starts with
defaults write com.apple.Safari FindOnPageMatchesWordStartsOnly -bool false

# safari: remove useless icons from safari’s bookmarks bar
defaults write com.apple.Safari ProxiesInBookmarksBar "()"

# safari: enable the develop menu and the web inspector in safari
defaults write com.apple.Safari IncludeDevelopMenu -bool true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true

# safari: add a context menu item for showing the web inspector in web views
defaults write NSGlobalDomain WebKitDeveloperExtras -bool true

# safari: enable continuous spellchecking
defaults write com.apple.Safari WebContinuousSpellCheckingEnabled -bool true

# safari: disable auto-correct
defaults write com.apple.Safari WebAutomaticSpellingCorrectionEnabled -bool false

# safari: disable autofill
defaults write com.apple.Safari AutoFillFromAddressBook -bool false
defaults write com.apple.Safari AutoFillPasswords -bool false
defaults write com.apple.Safari AutoFillCreditCardData -bool false
defaults write com.apple.Safari AutoFillMiscellaneousForms -bool false

# safari: warn about fraudulent websites
defaults write com.apple.Safari WarnAboutFraudulentWebsites -bool true

# safari: disable plug-ins
defaults write com.apple.Safari WebKitPluginsEnabled -bool false
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2PluginsEnabled -bool false

# safari: disable java
defaults write com.apple.Safari WebKitJavaEnabled -bool false
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2JavaEnabled -bool false

# safari: block pop-up windows
defaults write com.apple.Safari WebKitJavaScriptCanOpenWindowsAutomatically -bool false
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2JavaScriptCanOpenWindowsAutomatically -bool false

# safari: disable auto-playing video
defaults write com.apple.Safari WebKitMediaPlaybackAllowsInline -bool false
defaults write com.apple.SafariTechnologyPreview WebKitMediaPlaybackAllowsInline -bool false
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2AllowsInlineMediaPlayback -bool false
defaults write com.apple.SafariTechnologyPreview com.apple.Safari.ContentPageGroupIdentifier.WebKit2AllowsInlineMediaPlayback -bool false

# safari: enable “do not track”
defaults write com.apple.Safari SendDoNotTrackHTTPHeader -bool true

# safari: update extensions automatically
defaults write com.apple.Safari InstallExtensionUpdatesAutomatically -bool true

# -----------------------------------------------------------------------------
# user applications
# -----------------------------------------------------------------------------

# iterm2: don’t display the annoying prompt when quitting
defaults write com.googlecode.iterm2 PrefsCustomFolder -string "$HOME/.dotfiles/configs/"

# iterm2: don’t display the annoying prompt when quitting
defaults write com.googlecode.iterm2 PromptOnQuit -bool false

# iterm2: install snazzy theme
open "$HOME/.dotfiles/configs/Snazzy.itermcolors"

# chrome: disable the all too sensitive backswipe on trackpads
defaults write com.google.Chrome AppleEnableSwipeNavigateWithScrolls -bool false
defaults write com.google.Chrome.canary AppleEnableSwipeNavigateWithScrolls -bool false

# chrome: use the system-native print preview dialog
defaults write com.google.Chrome DisablePrintPreview -bool true
defaults write com.google.Chrome.canary DisablePrintPreview -bool true

# chrome: expand the print dialog by default
defaults write com.google.Chrome PMPrintingExpandedStateForPrint2 -bool true
defaults write com.google.Chrome.canary PMPrintingExpandedStateForPrint2 -bool true

# -----------------------------------------------------------------------------
# finalize
# -----------------------------------------------------------------------------

# kill target application for applying the changes
for app in "Activity Monitor" \
  "System Preferences" \
  "Dock" \
  "Finder" \
  "SystemUIServer" \
  "Terminal" \
  "Photos" \
  "cfprefsd" \
  "Safari" \
  "iTerm2" \
  "Google Chrome" \
  "Google Chrome Canary";do
	killall "${app}" &> /dev/null
done

echo "Done. Note that some of these changes require a logout/restart to take effect."
