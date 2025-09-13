
alias vi=vim
alias ll='ls -l'
alias ec='emacsclient -nq'

alias -g V="| vim -R -"
alias -g G="| grep"
alias -g J="| json_pp"

alias gl='g l5'
alias gpl='g pull && g l5'
alias gst='g st'
alias gdw='g dw'
alias gdc='g diff --cached'

alias dk=docker
alias kc=kubectl
alias kns=kubens
alias dc=docker-compose
alias dkr='docker run -it --rm'
alias dke='docker exec -it'
alias dip='docker inspect --format "{{ .NetworkSettings.IPAddress }}"'
alias dip2='docker inspect -f "{{range .NetworkSettings.Networks}}{{.IPAddress}} {{end}}"'
alias dk-host-shell='docker run -it --rm --privileged --pid=host justincormack/nsenter1'
alias dkl='docker logs -f --tail=100'
alias kcl='kubectl logs -f --tail=100'
alias kcll='kubectl get pods --sort-by=.metadata.creationTimestamp | cut -f 1 -d " " | tail -n 1 | xargs kubectl logs --tail=100 -f'
alias kce='kubectl exec -it'
alias kcy='kubectl get -o yaml'

# Usage: kla channel --by-host
alias -g -- --by-host='--sort-by=.spec.nodeName'
alias -g -- --by-age='--sort-by=.metadata.creationTimestamp'
alias -g -- --by-ns='--sort-by=.metadata.namespace'

DEFAULT_SORT='--sort-by=.metadata.creationTimestamp'

kcld () {
    local name="$1"; shift
    kubectl logs -f --tail=100 deploy/$name $@
}
_kcld () {
    _arguments "1: :($(kubectl get deploy -o=jsonpath='{range .items[*].metadata.name}{@}{"\n"}{end}'))"
}
compdef '_kcld' kcld

kca () {
    local verb="$1"; shift
    kubectl $verb --all-namespaces $@
}
_kca () {
    if ! type __start_kubectl >/dev/null 2>&1; then
        _kubectl
    fi

    _bash_complete -o default -F __start_kubectl
}
compdef '_kca' kca

kla () {
    local label="$1"; shift
    kca get pods -o wide $DEFAULT_SORT -l app=$label $@
}

klh () {
    local node="$1"; shift
    kca get pods --field-selector spec.nodeName=$node $@
}
_klh () {
    _arguments "1: :($(kubectl get nodes -o=jsonpath='{range .items[*].metadata.name}{@}{"\n"}{end}'))"
}
compdef '_klh' klh

klp () {
    local args=''
    if [[ -n "$1" && "$1" != -* ]]; then
        args="-n $1"
        shift
    fi
    kubectl get pods -o wide $DEFAULT_SORT ${=args} $@
}
compdef '_kubens' klp

kln () {
    local args=''
    if [[ -n "$1" && "$1" != -* ]]; then
        args="-n $1"
        shift
    fi
    kubectl get svc,deploy,ds,sts ${=args} $@
}
compdef '_kubens' kln

kc-get-all () {
    for res in $(kubectl api-resources --verbs=list --namespaced -o name); do
        # local out=$(kubectl get --show-kind --ignore-not-found $res)
        local out=$(kubectl get --ignore-not-found $res)
        if [[ -n "$out" ]]; then
            echo "====================" $res "===================="
            echo "$out"
            echo
        fi
    done
}

# Show pods, using more than 0.1 core
khogs () {
    kubectl top pods -A | grep -ve ' \d\{1,2\}m ' | phe sort -k 3 -h -r
}

# Restart pods, associated with the deployment "foo" [in "bar" ns]:
#
#     krd foo [-n bar]
#
krd () {
    local deploy="$1"
    shift

    local patch_str='{"spec": {"template": {"metadata": {"annotations": {"restartTrigger":"'
    patch_str+="$(date)"
    patch_str+='"}}}}}'

    kubectl patch deploy "$deploy" -p "$patch_str" $@
}
_krd () {
    _arguments "1: :($(kubectl get deploy -o=jsonpath='{range .items[*].metadata.name}{@}{"\n"}{end}'))"
}
compdef '_krd' krd

function docker-sweep () {
    dk ps -a -q -f status=exited | paste -s - | xargs docker rm
    dk images -a -q -f dangling=true | paste -s - | xargs docker rmi
}

OS=$(uname)
if [[ "$OS" == "Darwin" ]]; then
    alias airport='/System/Library/PrivateFrameworks/Apple80211.framework/Resources/airport'
    alias flushdns='dscacheutil -flushcache;sudo killall -HUP mDNSResponder'
fi
