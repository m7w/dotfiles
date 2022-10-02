### History
# /etc/zshrc sourced after .zshenv and overwrite
# next settings if it placed in .zshenv
export HISTFILE=$ZDOTDIR/.zsh_history

# How many commands zsh will load to memory.
export HISTSIZE=10000

# How maney commands history will save on file.
export SAVEHIST=10000

# History won't save duplicates.
setopt HIST_IGNORE_ALL_DUPS

# History won't show duplicates on search.
setopt HIST_FIND_NO_DUPS

### LS_COLORS
eval `dircolors $HOME/.config/dir_colors/solarized.dircolors`

### Theme
fpath=($ZDOTDIR/themes $fpath)
autoload -Uz prompt.zsh; prompt.zsh

### Plugins
source $ZDOTDIR/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
source $ZDOTDIR/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh
# source $ZDOTDIR/plugins/zsh-interactive-cd/zsh-interactive-cd.plugin.zsh
# source $ZDOTDIR/plugins/zsh-vi-mode/zsh-vi-mode.plugin.zsh
source $ZDOTDIR/plugins/bd/bd.zsh

source $ZDOTDIR/scripts.zsh
source $ZDOTDIR/completion.zsh

setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS
setopt PUSHD_SILENT
setopt SHARE_HISTORY

### Other
# widgets
zle -N open_with_fzf
zle -N cd_with_fzf

# bindkey
bindkey -s '^X@so' 'open_with_fzf^M'
bindkey -s '^X@sc' 'cd_with_fzf^M'
bindkey -s '^X@sd' 'del_with_fzf^M'

# Search in history by Up/Down arrow
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward

# aliases
test -s $HOME/.aliases && . $HOME/.aliases || true
