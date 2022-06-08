export EDITOR=vim

export PYTHONSTARTUP="$HOME/.pyrc"
export PYTHONIOENCODING="UTF-8"

if [ -f $ZSH_CUSTOM/local-env.sh ]; then
    source $ZSH_CUSTOM/local-env.sh
fi

# 3rd-party binaries
if [[ -n $GRAALVM_HOME ]]; then
    # NOTE Shadow normal java installation
    export PATH=$GRAALVM_HOME/bin:$PATH
fi
if [[ -d $HOME/.pyenv/shims ]]; then
    # NOTE Shadow system/brew python(s)
    export PATH=$HOME/.pyenv/shims:$PATH
fi
if [[ -d $HOME/.krew/bin ]]; then
    export PATH=$PATH:$HOME/.krew/bin
fi

# Local scripts
if [[ -d $HOME/Library/bin ]]; then
    export PATH=$HOME/Library/bin:$PATH
fi
