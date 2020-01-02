# Path {{{
export PATH="/usr/local/bin:$PATH"
if uname -s | grep -q "Linux"; then
    eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
fi
# }}}

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
bindkey '^j' autosuggest-accept
# }}}

# PS1, Git Prompt, & Enable Colors {{{
autoload -U colors && colors
if [ ! -f ~/.git-prompt.sh ]; then
  echo "~/.git-prompt.sh is missing. Downloading..."
  curl -fL https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh --output ~/.git-prompt.sh
fi
[ -f ~/.git-prompt.sh ] && source ~/.git-prompt.sh  # Source for __git_ps1
setopt PROMPT_SUBST;  # Needed for __git_ps1 prompt
PS1=$'\n%F{14}%~%F{1} // %F{14}$(__git_ps1 "(%s)")\n%B$ %f%b'
# }}}

# Zsh Settings {{{
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt autocd
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
export TERM="xterm-256color"
[ -z "$TMUX" ] && tmux new-session -A -s main
# }}}

# FZF include hidden files
export FZF_DEFAULT_COMMAND='rg --hidden --glob "!.git" --files-with-matches ""'

# Other {{{
export EDITOR="vim"
alias python=python3
# }}}

# WSL specific profile
if uname -r | grep -q "Microsoft"; then
    [ -f ~/.wsl_profile ] && . ~/.wsl_profile
fi

