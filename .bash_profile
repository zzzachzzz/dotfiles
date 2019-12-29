# Aliases
alias python=python3

# Tmux
export TERM="xterm-256color"
[ -z "$TMUX" ] && tmux new-session -A -s main

# Bash completion
[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion

# FZF include hidden files
export FZF_DEFAULT_COMMAND='rg --hidden --glob "!.git" --files-with-matches ""'

# Other
export EDITOR="vim"
export PATH="/usr/local/bin:$PATH"
export BASH_SILENCE_DEPRECATION_WARNING=1

# WSL Specific Profile
if uname -r | grep -q "Microsoft"; then
    [ -f ~/.wsl_bash_profile ] && . ~/.wsl_bash_profile
fi

# PS1 & Git Prompt
red=$(tput setaf 1);
aqua=$(tput setaf 14);
bold=$(tput bold);
reset=$(tput sgr0);
PS1="\n";
PS1+="\[${aqua}\]\w";  # Working directory
PS1+="\[${red}\] //";
PS1+='\[${aqua}\]$(__git_ps1 " (%s)")';  # Git branch
PS1+="\n";
PS1+="\[${bold}\]\[${aqua}\]\$ \[${reset}\]";
export PS1;

