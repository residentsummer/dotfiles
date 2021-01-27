# Some personal shell customizations

# Disable special chars escaping when pasting URL into quotes
zstyle :bracketed-paste-magic paste-init backward-extend-paste

mkcd () {
    mkdir -p $1
    cd $1
}

# Usage: ps aux | preserve-header grep Emacs
preserve-header () {
    (read -r; printf "%s\n" "$REPLY"; eval "$@")
}
compdef _precommand preserve-header

remux () {
    host=$1
    shift
    ssh $host -t -C "tmux $@ attach -t remux || tmux -u $@ new -s remux"
}

xml_pp () {
    xmllint --noent --encode UTF-8 --format -
}

