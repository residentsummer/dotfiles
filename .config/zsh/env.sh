export PATH=$HOME/.pyenv/shims:/usr/local/bin:$PATH
export EDITOR=vim

export PYTHONSTARTUP="$HOME/.pyrc"
export PYTHONIOENCODING="UTF-8"

if [ -f $ZSH_CUSTOM/local-env.sh ]; then
    source $ZSH_CUSTOM/local-env.sh
fi

