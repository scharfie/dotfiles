. ~/.zsh/config
. ~/.zsh/aliases
. ~/.zsh/completion
# . ~/.zsh/plugins/*/*.zsh /dev/null 2>&1

# use .localrc for settings specific to one system
[[ -f ~/.localrc ]] && .  ~/.localrc

# [[ -s $HOME/.rvm/scripts/rvm ]] && source $HOME/.rvm/scripts/rvm

# export PATH="./bin:$HOME/.rbenv/bin:$PATH"

# eval "$(rbenv init -)"

# go to the marked directory
gm
source $HOME/.iterm2_shell_integration.zsh
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Setting ag as the default source for fzf
# -U means do NOT respect .gitignore but DO respect .agignore
export FZF_DEFAULT_COMMAND='ag -U -l -g ""'

# To apply the command to CTRL-T as well
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"


# source ~/.zsh/plugins/zsh-snippets/snippets.plugin.zsh
# bindkey "G" snippet-expand
# # bindkey -M isearch " " self-insert

# snippet-add "g" "gcm \"`git symbolic-ref HEAD --short` "
