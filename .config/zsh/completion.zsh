### Completion
# Additional completions
fpath=($HOME/.local/share/zsh/completions $fpath)

zmodload zsh/complist


autoload -Uz compinit && compinit
# if [ $(find $ZDOTDIR/.zcompdump -mmin +120) ]; then
#     compinit
# else
#     compinit -CD -d $ZDOTDIR/.zcompdump
# fi
_comp_options+=(globdots)

autoload bashcompinit && bashcompinit
complete -C '/usr/local/bin/aws_completer' aws

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
