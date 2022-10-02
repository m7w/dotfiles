mkdir -p $ZDOTDIR/plugins/bd
curl https://raw.githubusercontent.com/Tarrasch/zsh-bd/master/bd.zsh > $ZDOTDIR/plugins/bd/bd.zsh
git clone https://github.com/zsh-users/zsh-autosuggestions $ZDOTDIR/plugins/zsh-autosuggestions
git clone https://github.com/zdharma-continuum/fast-syntax-highlighting $ZDOTDIR/plugins/fast-syntax-highlighting
