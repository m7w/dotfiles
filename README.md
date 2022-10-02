## dotfiles

### Installation

1. echo ".dotfiles" >> .gitignore
2. git clone \<repo-url\> $HOME/.dotfiles
3. alias dotfiles="git --git-dir=\$HOME/.dotfiles/.git --work-tree=\$HOME
4. dotfiles config --local status.showUntrackedFiles no
5. dotfiles checkout
