
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(status background_jobs context dir)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(vcs time)
POWERLEVEL9K_TIME_FORMAT='%D{%H:%M}'
POWERLEVEL9K_TIME_FOREGROUND='blue'
POWERLEVEL9K_TIME_BACKGROUND='black'
POWERLEVEL9K_STATUS_OK='false'
POWERLEVEL9K_DIR_DEFAULT_FOREGROUND='white'
POWERLEVEL9K_DIR_HOME_FOREGROUND='white'
POWERLEVEL9K_DIR_HOME_SUBFOLDER_FOREGROUND='white'
POWERLEVEL9K_DIR_ETC_FOREGROUND='white'
POWERLEVEL9K_CONTEXT_DEFAULT_FOREGROUND='white'

# Drop useless space at the end of RPROMPT
ZLE_RPROMPT_INDENT=0

if [[ -n "$POWERLEVEL10K_PATH" ]]; then
    source "$POWERLEVEL10K_PATH/powerlevel10k.zsh-theme"
fi
