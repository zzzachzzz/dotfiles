ln -s ~/git/dotfiles/.zshrc ~/.zshrc
ln -s ~/git/dotfiles/.tmux.conf ~/.tmux.conf
ln -s ~/git/dotfiles/.vimrc ~/.vimrc
ln -s ~/git/dotfiles/nvim/ ~/.config/nvim
ln -s ~/git/dotfiles/custom_base16_monokai.vim "${XDG_DATA_HOME:-$HOME/.local/share}/nvim/site/pack/packer/start/vim-airline-themes/autoload/airline/themes/"
ln -s ~/git/dotfiles/.ignore ~/.ignore
ln -s ~/git/dotfiles/.gitignore_global ~/.gitignore_global
ln -s ~/git/dotfiles/.gitconfig ~/.gitconfig
ln -s ~/git/dotfiles/.pdbrc.py ~/.pdbrc.py
ln -s ~/git/dotfiles/.vimrc_ide ~/git/dotfiles/sublime/.neovintageousrc

# Linux {{{
# VSCode
# ln -s ~/git/dotfiles/vscode/keybindings.json ~/.config/Code/User/keybindings.json
# ln -s ~/git/dotfiles/vscode/settings.json ~/.config/Code/User/settings.json

# Sublime
# ln -s ~/git/dotfiles/sublime/ ~/.config/sublime-text/Packages/User
# }}}

# OSX {{{
# VSCode
# ln -s ~/git/dotfiles/vscode/keybindings.json ~/Library/Application\ Support/Code/User/keybindings.json
# ln -s ~/git/dotfiles/vscode/settings.json ~/Library/Application\ Support/Code/User/settings.json

# Sublime
# ln -s ~/git/dotfiles/sublime/ ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User
# }}}

# Windows {{{
# Windows symlinks (from cmd)
# VSCode
# mklink "%UserProfile%\AppData\Roaming\Code\User\keybindings.json" "%UserProfile%\git\dotfiles\vscode\keybindings.json"
# mklink "%UserProfile%\AppData\Roaming\Code\User\settings.json" "%UserProfile%\git\dotfiles\vscode\settings.json"

# Sublime
# mklink /D "%UserProfile%\AppData\Roaming\Sublime Text 3\Packages\User" "%UserProfile%\_\git\dotfiles\sublime"

# WSL specific config
# ln -s ~/git/dotfiles/.wsl.zsh ~/.wsl.zsh
# }}}

