
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

# Usage: by-host kla channel
by-host () {
    $@ --sort-by=.spec.nodeName
}

by-ns () {
    $@ --sort-by=.metadata.namespace
}

by-age () {
    $@ --sort-by=.metadata.creationTimestamp
}

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

kcy () {
    kubectl get -o yaml $@
}

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

klp () {
    local args=''
    if [[ -n "$1" ]]; then
        args="-n $1"
    fi
    kubectl get pods -o wide $DEFAULT_SORT ${=args}
}

kln () {
    local args=''
    if [[ -n "$1" ]]; then
        args="-n $1"
    fi
    kubectl get svc,deploy,ds,sts ${=args}
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

OS=$(uname)
if [[ "$OS" == "Darwin" ]]; then
    alias airport='/System/Library/PrivateFrameworks/Apple80211.framework/Resources/airport'
    alias flushdns='dscacheutil -flushcache;sudo killall -HUP mDNSResponder'
fi
