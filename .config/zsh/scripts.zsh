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
    cd $(fd -t d | fzf --preview="tree -L 1 {}" --preview-window=:hidden --bind=space:toggle-preview)
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
