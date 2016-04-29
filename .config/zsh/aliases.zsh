
alias vi=vim
alias ll='ls -l'
alias ec='emacsclient -nq'

alias -g V="| vim -R -"
alias -g G="| grep"

alias dk=docker
alias dc=docker-compose
alias dkr='docker run -it --rm'
alias dex='docker exec -it'
alias dip='docker inspect --format "{{ .NetworkSettings.IPAddress }}"'

OS=$(uname)
if [[ "$OS" == "Darwin" ]]; then
    alias airport='/System/Library/PrivateFrameworks/Apple80211.framework/Resources/airport'
    alias flushdns='dscacheutil -flushcache;sudo killall -HUP mDNSResponder'
fi

