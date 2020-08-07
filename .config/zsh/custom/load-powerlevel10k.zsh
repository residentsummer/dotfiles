# Drop useless space at the end of RPROMPT
ZLE_RPROMPT_INDENT=0

if [[ -n "$POWERLEVEL10K_PATH" ]]; then
    # To customize prompt, run `p10k configure` or edit ../p10k.zsh.
    [[ ! -f ${0:a:h}/../p10k.zsh ]] || source ${0:a:h}/../p10k.zsh

    source "$POWERLEVEL10K_PATH/powerlevel10k.zsh-theme"
fi

