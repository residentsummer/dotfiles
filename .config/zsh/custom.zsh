# Some personal shell customizations

# Ctrl-Z in shell resumes last suspended job
fancy-ctrl-z () {
  if [[ $#BUFFER -eq 0 ]]; then
    BUFFER="fg"
    zle accept-line
  else
    zle push-input
    zle clear-screen
  fi
}
zle -N fancy-ctrl-z
bindkey '^Z' fancy-ctrl-z

mkcd () {
    mkdir -p $1
    cd $1
}

