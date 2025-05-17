nnvim() {
    NVIM_APPNAME="nvim_test" ~/programs/nvim-nightly/bin/nvim
}

serve() {
    python3 -m http.server 8000
}

pacs() {
    rpm -qa --qf "%{NAME}\n" | fzf --preview 'zypper info {}' --preview-window=:hidden --bind=space:toggle-preview
}

open_with_fzf() {
    fd -t f -H -I | fzf -m --preview="xdg-mime query filetype {} | xargs xdg-mime query default" | xargs -r -d "\n" xdg-open 2>&-
}
cd_with_fzf() {
    cd $(fd -t d | fzf --preview="tree -L 1 {}" --preview-window=:hidden --bind "space:toggle-preview")
}
del_with_fzf() {
    fd . | fzf --bind "del:execute(rm {})"
}

git_squash_add_all() {
    commit=$(git log --oneline | fzf | awk '{ print $1 }')
    prepared_message=$(git log --format=%s $commit..HEAD)
    git reset --soft $commit && git add -A && git commit -e -m "$prepared_message"
}

docker_stop() {
    container=$(docker container ls | tail -n +2 | fzf | awk '{ print $1 }')
    docker stop $container
}

docker_delete_dangling() {
    image_hash=$(docker image ls -f dangling=true | tail -n +2 | fzf | awk '{ print $3 }')
    docker rmi $image_hash
}

refresh_completions() {
    curl -sSL https://raw.githubusercontent.com/zsh-users/zsh-completions/master/src/_golang >$HOME/.local/share/zsh/completions/_golang
    curl -sSL https://raw.githubusercontent.com/zsh-users/zsh-completions/master/src/_mvn >$HOME/.local/share/zsh/completions/_mvn
    curl -sSL https://raw.githubusercontent.com/gradle/gradle-completion/master/_gradle >$HOME/.local/share/zsh/completions/_gradle
    curl -sSL https://raw.githubusercontent.com/jupyter/jupyter_core/main/examples/completions-zsh >$HOME/.local/share/zsh/completions/_jupyter

    kind completion zsh > $HOME/.local/share/zsh/completions/_kind
    minikube completion zsh > $HOME/.local/share/zsh/completions/_minikube
    helm completion zsh > $HOME/.local/share/zsh/completions/_helm 
    kubectl completion zsh > $HOME/.local/share/zsh/completions/_kubectl
}
