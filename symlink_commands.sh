ln -s ~/git/dotfiles/.zshrc ~/.zshrc
ln -s ~/git/dotfiles/.tmux.conf ~/.tmux.conf
ln -s ~/git/dotfiles/.vimrc ~/.vimrc
ln -s ~/git/dotfiles/.config/nvim/ ~/.config/nvim
ln -s ~/git/dotfiles/custom_base16_monokai.vim "${XDG_DATA_HOME:-$HOME/.local/share}/nvim/site/pack/packer/start/vim-airline-themes/autoload/airline/themes/"
ln -s ~/git/dotfiles/.ignore ~/.ignore
ln -s ~/git/dotfiles/.gitignore_global ~/.gitignore_global
ln -s ~/git/dotfiles/.gitconfig ~/.gitconfig
ln -s ~/git/dotfiles/.pdbrc.py ~/.pdbrc.py
ln -s ~/git/dotfiles/.vimrc_ide ~/git/dotfiles/sublime/.neovintageousrc

# Linux {{{
# ln -s ~/git/dotfiles/vscode/ ~/.config/Code/User
# ln -s ~/git/dotfiles/sublime/ ~/.config/sublime-text/Packages/User
# }}}

# OSX {{{
# ln -s ~/git/dotfiles/vscode/ ~/Library/Application\ Support/Code/User
# ln -s ~/git/dotfiles/sublime/ ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User
# }}}

# Windows {{{
# Windows symlinks for WSL (from cmd)
# mklink /D "%UserProfile%\AppData\Roaming\Code\User" "%UserProfile%\_\git\dotfiles\vscode"
# mklink /D "%UserProfile%\AppData\Roaming\Sublime Text 3\Packages\User" "%UserProfile%\_\git\dotfiles\sublime"

# WSL specific config
# ln -s ~/git/dotfiles/.wsl.zsh ~/.wsl.zsh
# }}}

