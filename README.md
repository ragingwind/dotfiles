# dotfiles

> dotfiles for @ragingwind

## Quick Start for macOS

```sh
# bootstrap to install essential applications
sh ./bootstrap.sh

# configure macOS envrionment, system and apps you installed
sh ./macos.sh
```
## How I Do Setup macOS

### Clone dotfiles

First of all, you need to download dotfile project from github. To do this, simply, open terminal and run `git` on terminal. If you are not ready to use git, you will see.

- System will ask you to install `Command Line Tools` or `Xcode` on macOS.
- Choose a tools what you want to install
- Run `sudo xcodebuild -license` to do sign Xcode/iOS license to complete installation for git

When you can use git on terminal, do clone dotfiles project from github at root of current user by running:

- `git clone `[`https://github.com/ragingwind/dotfiles.git`](https://github.com/ragingwind/dotfiles.git)` ~/.dotfiles`

### Bootstraping

We need to install a very few application firsly. It called `bootstraping`.

- Get into `.dotfiles` just downloaded which you make sure that. Rest of restoration processes will happen in the path
- Run `sh bootstrap.sh` to install essential application managers like**rvm**, managing multiple ruby versions**nvm**, managing multiple node.js versions**node.js lts version** will be installed**yarn**, is a knock-out, period!**essential setting tools** for [making symbolic link](https://www.npmjs.com/package/@moonandyou/symlinks-cli) of dotfiles**brew**, installatioan bundch of macOS at once. **only for macOS**

### Installation of macOS applications with Brew

You can install all of essential applications on macOS via [brew](https://brew.sh/)/[cask](https://caskroom.github.io/), which also supports that set up fonts, MAS apps, development tools like compilers, runtimes, even IDEs and editors through. `Brewfile` in `~/.dotfiles` is a manifest for application list you want to install.

- During in period of boostraping, `brew bundle` will be executed with` Brewfile`*In case of MAS apps is not in the list because of security issues*
- Take a break. It could take so much time by your applications count and sizes in `Brewfile`
- Run your favorite cloud sync app to sync with your backup data to local,  which allow you be able to retore settings
  - Google Drive or Dropbox that kind of sync clients must be installed if your dotfiles is on the cloud. *As for me, private dotfiles synced in case of no tracking like ssh, aws files.*

### Restore settings

dotfiles restoration consists of two of parts. The first part is that link private dotfiles synced with cloud and `.mackup` directory and `.mackup.cfg` at root of user, $HOME. Create symlinks at once by run below command.

- `sn ~/Google Drive/.dotfiles/* ~/dotfiles/mackup* $HOME --hidden`[symlinks-cli](https://www.npmjs.com/package/@moonandyou/symlinks-cli) tool is already installed as bootstraping. 

`mackup` will be used in the next step to restore all of settings for your application you installed via brew, which is also downloaded by brew, is to keep your application setting in sync not only dotfiles also macOS apps.

- Check out `.mackup` directory and `.mackup.cfg` exists at root of the user
- Run `mackup restore` which allow all of setting to restore for each applicationsWhen you feel that backup setting of apps, run `mackup backup`. Please visit to official site to get more help

### Configuration macOS

Instead of manually configuring macOS, using macOS scripts and shell command by running `sh macos.sh` to help us configure those of settings on macOS [automatically](https://mths.be/macos). This step covers those of apps below.

- System, Shell and Bundled Application like dock, finder, safari, activity monitor, environments, global ui/ux
- User applications: Chrome, iTerm2 and more

After configuring macOS, UIServer and apps will be restarted and you need to restart your system if the changes work well. If you're interested in maintain the scripts? you should take a look at the `macos.sh` to customize for every configs you need. If you need more sample? please refer to below sites.

- [Mathias Bynens's .macos](https://mths.be/macos)
- [kevinSuttle - macOS-Defaults](https://goo.gl/cjbYbJ)
- [awesome-osx-command](https://github.com/herrbischoff/awesome-osx-command-linehttps://github.com/herrbischoff/awesome-osx-command-line)

# License

MIT @ [Jimmy Moon](http://ragingwind.me)
