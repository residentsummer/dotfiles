# Some personal shell customizations

mkcd () {
    mkdir -p $1
    cd $1
}

remux () {
    host=$1
    shift
    ssh $host -t -C "tmux $@ attach -t remux || tmux $@ new -s remux"
}

