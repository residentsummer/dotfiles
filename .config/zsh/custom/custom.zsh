# Some personal shell customizations

# Disable special chars escaping when pasting URL into quotes
zstyle :bracketed-paste-magic paste-init backward-extend-paste

mkcd () {
    mkdir -p $1
    cd $1
}

# Usage: ps aux | preserve-header grep Emacs
phe () {
    (read -r; printf "%s\n" "$REPLY"; eval "$@")
}
compdef _precommand phe

remux () {
    host=$1
    shift
    ssh $host -t -C "tmux $@ attach -t remux || tmux -u $@ new -s remux"
}

xml_pp () {
    xmllint --noent --encode UTF-8 --format -
}

shrink_pdf () {
    if [[ -z "$1" || -z "$2" ]]; then
        echo "usage: shrink_pdf infile outfile"
        return 1
    fi

    # https://medium.com/@treyharris/converting-a-scanned-document-into-a-compressed-searchable-pdf-with-redactions-63f61c34fe4c
    gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/ebook -dNOPAUSE -dQUIET -dBATCH "-sOutputFile=${2}" "${1}" >/dev/null
}

pie () {
    if [[ -z "$1" || -z "$3" ]]; then
        echo "usage: replace before after file [... file]"
        echo
        echo "example:"
        echo "    replace foo \"\" **/*.py"
        return 1
    fi

    local before=$1
    local after=$2
    shift 2

    for f in $@; do
        if [[ -f "$f" ]]; then
            # perl -pi -e "$M=$_ s/$before/$after/; END{exit 1 unless $M>0}" "$f"
            perl -pi -e "s/$before/$after/" "$f"
        fi
    done
}

