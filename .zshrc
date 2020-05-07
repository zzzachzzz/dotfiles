# Path {{{
export PATH="/usr/local/bin:$HOME/.local/bin:$HOME/bin:$PATH"
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
bindkey '^^' autosuggest-accept  # Ctrl + Enter
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
PS1=$'\n%F{14}%~%F{1} // %F{14}$(__git_ps1 "(%s)")\n%B$ %f%b'
# }}}

# Zsh Settings {{{
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
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
export FZF_DEFAULT_COMMAND='rg --hidden --ignore-file ~/.ignore --files-with-matches ""'

# Other {{{
export EDITOR="vim"
alias python=python3
alias mktags="ctags -R --exclude=@$HOME/.ignore --exclude='*.json' --exclude='*.yaml' ."
alias vimS="vim -S ~/.vim/sessions/"
export CXXFLAGS="-std=c++14"
# }}}

# WSL specific profile
if uname -r | grep -q "Microsoft"; then
    [ -f ~/.wsl_profile ] && . ~/.wsl_profile
fi

