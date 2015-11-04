
alias vi=vim
alias ll='ls -l'

alias -g V="| vim -R -"
alias -g G="| grep"

alias dk=docker
alias fl=fleetctl
alias fig=docker-compose
alias dkr='docker run -it --rm'
alias dex='docker exec -it'

OS=$(uname)
if [[ "$OS" == "Darwin" ]]; then
    alias airport='/System/Library/PrivateFrameworks/Apple80211.framework/Resources/airport'
fi

