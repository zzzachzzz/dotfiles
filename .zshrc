# Path {{{
export PATH="/usr/local/bin:$HOME/.local/bin:$HOME/bin:$PATH"
if uname -s | grep -q "Linux" && [[ -f /home/linuxbrew/.linuxbrew/bin/brew ]]; then
    eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
fi
# }}}

# WSL specific profile
if uname -r | grep -iq "microsoft"; then
  alias cmd="cmd.exe"
  alias psh="powershell.exe"
  alias explorer="explorer.exe"
  alias subl="subl.exe"
  alias code="code.exe"
  alias chrome="chrome.exe"
  # For VcXsrv to sync WSL & Windows clipboards
  export DISPLAY=$(awk '/nameserver / {print $2; exit}' /etc/resolv.conf 2>/dev/null):0
  export LIBGL_ALWAYS_INDIRECT=1
fi

# Oh-My-Zsh {{{
export ZSH=~/.oh-my-zsh
ZSH_THEME="robbyrussell"
HYPHEN_INSENSITIVE="true"
plugins=()
source $ZSH/oh-my-zsh.sh
# }}}

# Zplug {{{
source ~/.zplug/init.zsh
# Plugins {{{
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "zsh-users/zsh-autosuggestions"
zplug "plugins/colored-man-pages", from:oh-my-zsh
zplug "plugins/extract", from:oh-my-zsh
# }}}
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi
zplug load
# }}}

# Zsh Plugin Keybinds {{{
bindkey '^y' autosuggest-accept
# }}}

# Misc. Files to Download if Missing {{{
files=(
  ~/.git-prompt.sh  # For __git_ps1
)
urls=(
  https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh
)
for i in {1..$#files}; do
  if [ ! -f $files[$i] ]; then
    echo "$files[$i] is missing. Downloading..."
    curl -fL $urls[$i] --output $files[$i]
  fi
done
unset files urls i
# }}}

# PS1, Git Prompt, & Enable Colors {{{
autoload -U colors && colors
[ -f ~/.git-prompt.sh ] && source ~/.git-prompt.sh  # Source for __git_ps1
setopt PROMPT_SUBST;  # Needed for __git_ps1 prompt
PS1=$'\n%F{81}%~%F{1} %F{197}// %F{72}$(__git_ps1 "%s")%f\n%B%F{135}$ %k%f%b'
# }}}

# Zsh Settings {{{
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
setopt autocd
setopt ignoreeof
setopt extended_glob
autoload -Uz compinit
compinit
# }}}

# FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Edit line in Vim with <C-e> {{{
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line
# }}}

# Tmux & auto attach to session {{{
function atmux() { tmux new-session -A -s "${1:=main}" }
# }}}

# FZF use ripgrep and include hidden files
export FZF_DEFAULT_COMMAND='rg --hidden --ignore-file ~/.ignore --files'

# fd use ignore file
alias fd='fd --ignore-file ~/.ignore'

# Other {{{
export EDITOR="nvim"
alias pm="pacman --color=always"
alias yay="yay --color=always"
alias python=python3
alias mktags="ctags -R --exclude=@$HOME/.ignore --exclude='*.json' --exclude='*.yaml' ."
alias vim="nvim"
alias mvim="vim -u NONE" # For quick minimal vim loading no vimrc
function vims() {
  local filepath="$HOME/.vim/sessions/${PWD##*/}.vim"
  if [ -f $filepath ]; then
    vim -S $filepath
  else
    vim -c "Obsess $filepath"
  fi
}
alias vimS="vim -S ~/.vim/sessions/"
alias gs="git status"
alias gd="git diff"
alias gdc="git diff --cached"
alias gl="git log"
alias clipc="xclip -in -sel clipboard -rmlastnl"
alias clipp="xclip -out -sel clipboard -rmlastnl"

export CXXFLAGS="-std=c++14"
export LS_COLORS='ow=1;90;107'
export IGNOREEOF=4

# For programs without man pages
function manh() { "$@" --help | less }

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
    pretty_json=$(jq --color-output '.' /tmp/curls_body 2> /dev/null)
    if [ $? -eq 0 ]; then
      echo $pretty_json
    else
      cat /tmp/curls_body
      echo ""
    fi
    echo "\n$response_code_and_method"
  fi
}
# }}}

[ -f ~/.zshrc-local ] && source ~/.zshrc-local
