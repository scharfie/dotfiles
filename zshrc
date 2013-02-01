. ~/.zsh/config
. ~/.zsh/aliases
. ~/.zsh/completion
# . ~/.zsh/plugins/*/*.zsh /dev/null 2>&1

# use .localrc for settings specific to one system
[[ -f ~/.localrc ]] && .  ~/.localrc

# [[ -s $HOME/.rvm/scripts/rvm ]] && source $HOME/.rvm/scripts/rvm

export PATH="./bin:$PATH"

# go to the marked directory
gm
