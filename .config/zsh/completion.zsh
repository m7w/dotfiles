### Completion
# Additional completions
fpath=($ZDOTDIR/plugins/zsh-completions/src $fpath)

autoload -Uz compinit
for dump in $ZDOTDIR/.zcompdump(N.mh+24); do
    compinit
done
compinit -C
_comp_options+=(globdots)

zmodload zsh/complist

# Options
setopt AUTO_LIST
setopt COMPLETE_IN_WORD

# zstyle ':completion:<function>:<completer>:<command>:<argument>:<tag> <style> <values>'

# Completers
zstyle ':completion:*' completer _extensions _expand_alias _complete _approximate

# Use cache
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path $ZDOTDIR/.zcompcache

zstyle ':completion:*' menu select

# Formatting
# color completion
zstyle ':completion:*:*:*:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:*:*:*:descriptions' format '%F{green}-- %d %l --%f'
zstyle ':completion:*:*:*:*:options' format '%F{blue}-- %d %l --%f'
zstyle ':completion:*:*:*:*:messages' format ' %F{purple} -- %d --%f'
zstyle ':completion:*:*:*:*:corrections' format '%F{yellow}-- %d (errors: %e)!!! --%f'
zstyle ':completion:*:*:*:*:warnings' format ' %F{red}-- no matches found --%f'

# Complete manual by their section
# zstyle ':completion:*:manuals'                      separate-sections true
# zstyle ':completion:*:manuals.*'                    insert-sections   true
# zstyle ':completion:*:man:*'                        menu yes select

# Grouping
zstyle ':completion:*' group-name ''
zstyle ':completion:*:*:-command-:*:*' group-order aliases builtins functions commands

zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]}'

# List like ls -l
# zstyle ':completion:*' file-list all
