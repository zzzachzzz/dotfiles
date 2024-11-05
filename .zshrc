# Zplug {{{
source ~/.zplug/init.zsh
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "zsh-users/zsh-autosuggestions"
zplug "plugins/colored-man-pages", from:oh-my-zsh
zplug "plugins/extract", from:oh-my-zsh
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi
zplug load
# }}}

# Keybinds {{{
bindkey -e # Emacs key bindings
bindkey '^Y' autosuggest-accept # Ctrl-Y
bindkey '^[e' edit-command-line # Alt-E
bindkey '^[[1~' beginning-of-line # Home
bindkey '^[[4~' end-of-line # End
bindkey '^U' backward-kill-line # Ctrl-U
bindkey '^[[3~' delete-char # Delete
bindkey '^[[Z' reverse-menu-complete # Shift-Tab
bindkey '^[[1;5C' forward-word # Ctrl-RightArrow
bindkey '^[[1;5D' backward-word # Ctrl-LeftArrow
# }}}

# PS1, Git Prompt, & Enable Colors {{{
autoload -U colors && colors
[ -f ~/.git-prompt.sh ] && source ~/.git-prompt.sh  # Source for __git_ps1
setopt PROMPT_SUBST;  # Needed for __git_ps1 prompt
PS1=$'\n%F{81}%~%F{1} %F{197}// %F{72}$(__git_ps1 "%s")%f\n%B%F{141}$ %k%f%b'
# }}}

# Zsh Settings {{{
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt sharehistory
setopt autocd
setopt ignoreeof
autoload -Uz bashcompinit && bashcompinit
autoload -Uz compinit && compinit
zstyle ':completion:*' menu select
# Case insensitive completions
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
autoload edit-command-line
zle -N edit-command-line
# }}}

export PATH="$HOME/bin:$HOME/.local/bin:$HOME/.cargo/bin:$PATH"
export FZF_DEFAULT_COMMAND='rg --hidden --ignore-file ~/.ignore --files'
export IGNOREEOF=4
export EDITOR="nvim"
alias fd='fd --ignore-file ~/.ignore'
alias pm="pacman --color=always"
alias yay="yay --color=always"
alias mktags="ctags -R --exclude=@$HOME/.ignore --exclude='*.json' --exclude='*.yaml' ."
alias vim="nvim"
alias mvim="vim -u NONE" # For quick minimal vim loading no vimrc
alias vimS="vim -S ~/.config/nvim/sessions/"
function vims() {
  local filepath="$HOME/.config/nvim/sessions/${PWD##*/}.vim"
  if [ -f $filepath ]; then
    vim -S $filepath
  else
    vim -c "Obsess $filepath"
  fi
}
alias gs="git status"
alias gd="git diff"
alias gdc="git diff --cached"
alias gl="git log"
alias clipc="xclip -in -sel clipboard -rmlastnl"
alias clipp="xclip -out -sel clipboard -rmlastnl"
alias ls="ls --color=auto"
alias ll="ls -lh --color=auto"
alias la="ls -lhA --color=auto"
alias less="less --raw-control-chars"
alias help="run-help"
function atmux() { tmux new-session -A -s "${1:=main}" }
function manh() { "$@" --help | less } # For programs without man pages
alias apts='apt search --names-only'
alias dsf=diff-so-fancy

# Helper function for curl
function curls() {
  local response_code_and_method
  response_code_and_method=$(curl \
    --cookie ~/cookiefile \
    --cookie-jar ~/cookiefile \
    --no-progress-meter \
    --write-out "%{response_code} %{method}" \
    --output /tmp/curls_body \
    --header "Content-Type: application/json" \
    ${CURL_OPTIONS[@]} \
    $CURL_BASE_URL/$@
  )

  if [ $? -eq 0 ]; then
    local pretty_json
    pretty_json=$(jq $([ -z $nocolor ] && echo '--color-output') '.' /tmp/curls_body 2> /dev/null)
    if [ $? -eq 0 ]; then
      echo $pretty_json
    else
      cat /tmp/curls_body
      echo ""
    fi
    echo "\n$response_code_and_method"
  fi
}

function towslpath() {
  python3 << EOF
import re
winpath = r'$1'
driveletter = re.match(r'^\w', winpath)
assert driveletter is not None
wslpath = re.sub(r'^\w:', f'/mnt/{driveletter.group(0).lower()}', winpath)
wslpath = re.sub(r'\\\\', '/', wslpath)
print(wslpath)
EOF
}

# FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# WSL specific config
[ -f ~/.wsl.zsh ] && source ~/.wsl.zsh
# Per-machine local config
[ -f ~/.zshrc-local ] && source ~/.zshrc-local
