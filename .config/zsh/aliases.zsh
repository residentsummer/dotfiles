
alias vi=vim
alias ll='ls -l'
alias ec='emacsclient -nq'

alias -g V="| vim -R -"
alias -g G="| grep"
alias -g J="| json_pp"

alias gl='g l5'
alias gst='g st'
alias gdw='g dw'
alias gdc='g diff --cached'

alias dk=docker
alias kns=kubens
alias dc=docker-compose
alias dkr='docker run -it --rm'
alias dke='docker exec -it'
alias dip='docker inspect --format "{{ .NetworkSettings.IPAddress }}"'
alias dkl='docker logs -f --tail=100'
alias kcl='kubectl logs -f --tail=100'
alias kce='kubectl exec -it'
alias kcy='kubectl get -o yaml'

# Usage: by-host kla channel
by-host () {
    $@ --sort-by=.spec.nodeName
}
compdef _precommand by-host

by-ns () {
    $@ --sort-by=.metadata.namespace
}
compdef _precommand by-ns

by-age () {
    $@ --sort-by=.metadata.creationTimestamp
}
compdef _precommand by-age

DEFAULT_SORT='--sort-by=.metadata.creationTimestamp'

# Plain alias won't work with funcs below.
# e.g. `by-age kc get pods` will fail
kc () {
    kubectl $@
}

kca () {
    local verb="$1"
    shift
    kubectl $verb --all-namespaces $@
}

_kc () {
    if ! type __start_kubectl >/dev/null 2>&1; then
        _kubectl
    fi

    _bash_complete -o default -F __start_kubectl
}

compdef '_kc' kc
compdef '_kc' kca

kla () {
    local label="$1"
    shift
    kca get pods -o wide $DEFAULT_SORT -l app=$label $@
}

klh () {
    local node="$1"
    shift
    kca get pods $DEFAULT_SORT --field-selector spec.nodeName=$node $@
}

_klh () {
    _arguments "1: :($(kubectl get nodes -o=jsonpath='{range .items[*].metadata.name}{@}{"\n"}{end}'))"
}
compdef '_klh' klh

klp () {
    local args=''
    if [[ -n "$1" && "$1" != --* ]]; then
        args="-n $1"
        shift
    fi
    kubectl get pods -o wide $DEFAULT_SORT ${=args} $@
}
compdef '_kubens' klp

kln () {
    local args=''
    if [[ -n "$1" && "$1" != --* ]]; then
        args="-n $1"
        shift
    fi
    kubectl get svc,deploy,ds,sts ${=args} $@
}
compdef '_kubens' kln

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

OS=$(uname)
if [[ "$OS" == "Darwin" ]]; then
    alias airport='/System/Library/PrivateFrameworks/Apple80211.framework/Resources/airport'
    alias flushdns='dscacheutil -flushcache;sudo killall -HUP mDNSResponder'
fi
