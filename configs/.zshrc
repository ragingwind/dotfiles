# ZSH
ZSH=$HOME/.dotfiles/zsh

# initialize autocomplete here, otherwise functions won't be loaded
autoload -U compinit
compinit

# all of our zsh files
typeset -U config_files
config_files=($ZSH/**/*.zsh)

# load the path files
for file in ${(M)config_files:#*/path.zsh}
do
  source $file
done

# load everything but the path and completion files
for file in ${${config_files:#*/path.zsh}:#*/completion.zsh}
do
  source $file
done

# initialize autocomplete here, otherwise functions won't be loaded
autoload -U compinit
compinit

# load every completion after autocomplete loads
for file in ${(M)config_files:#*/completion.zsh}
do
  source $file
done

unset config_files

# Which plugins would you like to load?
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git)

# use .localrc for SUPER SECRET CRAP that you don't
# want in your public, versioned repo.
if [[ -a ~/.localrc ]]
then
  source ~/.localrc
fi

# exports configs
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
fpath=(/usr/local/share/zsh-completions/src $fpath)
