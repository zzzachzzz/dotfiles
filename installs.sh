# Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# OhMyZsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# zplug
curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh

# NeoVim
curl -L https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage -o ~/bin/nvim

# vim-plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# tmux-plugin-manager
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# RobotoMono Font
curl -L https://github.com/google/fonts/raw/main/apache/robotomono/static/RobotoMono-Regular.ttf -o RobotoMono-Regular.ttf
