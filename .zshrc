# Oh-My-Zsh {{{
export ZSH="/Users/zach/.oh-my-zsh"
ZSH_THEME="robbyrussell"
HYPHEN_INSENSITIVE="true"
plugins=()
source $ZSH/oh-my-zsh.sh
# }}}

# PS1, Git Prompt, & Enable Colors {{{
autoload -U colors && colors
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

# Aliases {{{
alias python=python3
# }}}

# Tmux & auto attach to session {{{
export TERM="xterm-256color"
[ -z "$TMUX" ] && tmux new-session -A -s main
# }}}

# FZF include hidden files
export FZF_DEFAULT_COMMAND='rg --hidden --glob "!.git" --files-with-matches ""'

# Other {{{
export EDITOR="vim"
export PATH="/usr/local/bin:$PATH"
# }}}

# WSL Specific Profile
if uname -r | grep -q "Microsoft"; then
    [ -f ~/.wsl_profile ] && . ~/.wsl_profile
fi

