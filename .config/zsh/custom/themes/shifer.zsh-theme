# vim:ft=zsh ts=2 sw=2 sts=2
#
# agnoster's Theme - https://gist.github.com/3712874
# A Powerline-inspired theme for ZSH
#
# # README
#
# In order for this theme to render correctly, you will need a
# [Powerline-patched font](https://github.com/Lokaltog/powerline-fonts).
#
# In addition, I recommend the
# [Solarized theme](https://github.com/altercation/solarized/) and, if you're
# using it on Mac OS X, [iTerm 2](http://www.iterm2.com/) over Terminal.app -
# it has significantly better color fidelity.
#
# # Goals
#
# The aim of this theme is to only show you *relevant* information. Like most
# prompts, it will only show git information when in a git working directory.
# However, it goes a step further: everything from the current user and
# hostname to whether the last call exited with an error to whether background
# jobs are running in this shell will all be displayed automatically when
# appropriate.

### Segment drawing
# A few utility functions to make it easy and re-usable to draw segmented prompts

CURRENT_BG='NONE'

start_prompt() {
  CURRENT_BG='NONE'
  RIGHT_PROMPT='NO'
  SEGMENT_SEPARATOR=''
  SEGMENT_SEPARATOR2=''
  echo -n "%{%f%k%b%}"
}

start_rprompt() {
  CURRENT_BG='NONE'
  RIGHT_PROMPT='YES'
  SEGMENT_SEPARATOR=''
  SEGMENT_SEPARATOR2=''
  echo -n "%{%f%k%b%}"
}

end_prompt() {
  if [[ $CURRENT_BG != 'NONE' ]]; then
    echo -n " %{%k%F{$CURRENT_BG}%}$SEGMENT_SEPARATOR%{%f%b%}"
  fi
  CURRENT_BG='NONE'
}

end_rprompt() {
  echo -n "%{%f%k%b%}"
  CURRENT_BG='NONE'
}

prompt_separate() {
  local old_bg new_bg new_fg
  old_bg="$CURRENT_BG"
  new_bg="$1"
  new_fg="$2"
  sep=""

  if [[ $old_bg == $new_bg ]]; then
    # Use light separator, if bg color is the same as before
    sep="%{%F{$new_fg}%}$SEGMENT_SEPARATOR2"
  elif [[ $old_bg != 'NONE' || $RIGHT_PROMPT == 'YES' ]]; then
    if [[ $RIGHT_PROMPT = 'NO' ]]; then
      sep="%{%F{$old_bg}%K{$new_bg}%}$SEGMENT_SEPARATOR"
    else
      sep="%{%K{$old_bg}%F{$new_bg}%}$SEGMENT_SEPARATOR"
    fi
  fi

  CURRENT_BG="$new_bg"
  echo -n " ${sep}%{%F{$new_fg}%K{$new_bg}%} "
}

# Begin a segment
# Takes two arguments, background and foreground. Both can be omitted,
# rendering default background/foreground.
prompt_segment() {
  local bg fg seg
  bg="$1"
  fg="$2"
  seg="$3"

  if [[ -n $seg ]]; then
    prompt_separate $bg $fg
    echo -n "$seg"
  fi
}

### Prompt components
# Each component will draw itself, and hide itself if no information needs to be shown

# Context: user@hostname (who am I and where am I)
prompt_context() {
  if [[ "$USER" != "$DEFAULT_USER" || -n "$SSH_CLIENT" ]]; then
    prompt_segment black white "%(!.%{%F{yellow}%}.)$USER@%m"
  fi
}

# Git: branch/detached head, dirty status
prompt_git() {
  local ref dirty bg mode repo_path
  repo_path=$(git rev-parse --git-dir 2>/dev/null)

  if $(git rev-parse --is-inside-work-tree >/dev/null 2>&1); then
    dirty=$(parse_git_dirty)
    ref=$(git symbolic-ref HEAD 2> /dev/null) || ref="➦ $(git show-ref --head -s --abbrev |head -n1 2> /dev/null)"
    if [[ -n $dirty ]]; then
      bg=yellow
    else
      bg=green
    fi

    if [[ -e "${repo_path}/BISECT_LOG" ]]; then
      mode="BISECT"
    elif [[ -e "${repo_path}/MERGE_HEAD" ]]; then
      mode="MERGE"
    elif [[ -e "${repo_path}/rebase" || -e "${repo_path}/rebase-apply" || -e "${repo_path}/rebase-merge" || -e "${repo_path}/../.dotest" ]]; then
      mode="REBASE"
    fi

    setopt promptsubst
    autoload -Uz vcs_info

    zstyle ':vcs_info:*' enable git
    zstyle ':vcs_info:*' get-revision true
    zstyle ':vcs_info:*' check-for-changes true
    zstyle ':vcs_info:*' stagedstr '✚'
    zstyle ':vcs_info:git:*' unstagedstr '●'
    zstyle ':vcs_info:*' formats ' %u%c'
    zstyle ':vcs_info:*' actionformats ' %u%c'
    vcs_info
    prompt_segment $bg black "${ref/refs\/heads\// }${vcs_info_msg_0_}"
    prompt_segment red black "${mode}"
  fi
}

prompt_hg() {
  local rev status bg fg
  if $(hg id >/dev/null 2>&1); then
    if $(hg prompt >/dev/null 2>&1); then
      if [[ $(hg prompt "{status|unknown}") = "?" ]]; then
        # if files are not added
        bg=red
        fg=white
        st='±'
      elif [[ -n $(hg prompt "{status|modified}") ]]; then
        # if any modification
        bg=yellow
        fg=black
        st='±'
      else
        # if working copy is clean
        bg=green
        fg=black
      fi
      prompt_segment $bg $fg "$(hg prompt " {rev}@{branch}") $st"
    else
      st=""
      rev=$(hg id -n 2>/dev/null | sed 's/[^-0-9]//g')
      branch=$(hg id -b 2>/dev/null)
      if `hg st | grep -q "^\?"`; then
        bg=red
        fg=black
        st='±'
      elif `hg st | grep -q "^[MA]"`; then
        bg=yellow
        fg=black
        st='±'
      else
        bg=green
        fg=black
      fi
      prompt_segment $bg $fg " $rev@$branch $st"
    fi
  fi
}

# Dir: current working directory
prompt_dir() {
  prompt_segment blue white '%2c'
}

# Virtualenv: current working virtualenv
prompt_virtualenv() {
  local virtualenv_path="$VIRTUAL_ENV"
  if [[ -n $virtualenv_path && -n $VIRTUAL_ENV_DISABLE_PROMPT ]]; then
    prompt_segment blue black "(`basename $virtualenv_path`)"
  fi
}

# Status:
# - was there an error
# - am I root
# - are there background jobs?
prompt_status() {
  local symbols
  symbols=()
  [[ $RETVAL -ne 0 ]] && symbols+="%{%F{red}%}✘"
  [[ $UID -eq 0 ]] && symbols+="%{%F{yellow}%}⚡"
  [[ $(jobs -l | wc -l) -gt 0 ]] && symbols+="%{%F{cyan}%}⚙"

  [[ -n "$symbols" ]] && prompt_segment black default "$symbols"
}

prompt_time() {
  prompt_segment black blue "%D{%H:%M}"
}

## Main prompt
build_prompt() {
  RETVAL=$?
  start_prompt
  prompt_status
  prompt_context
  prompt_dir
  end_prompt
}

## Main rprompt
build_rprompt() {
  start_rprompt
  prompt_git
  # prompt_hg
  prompt_time
  end_rprompt
}

PROMPT='$(build_prompt) '
RPROMPT='$(build_rprompt)'

