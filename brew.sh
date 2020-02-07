brew install python
brew install node
brew install grip
brew install tree
brew install ripgrep
brew install jq
brew install tmux
brew install zsh
brew install --HEAD universal-ctags/universal-ctags/universal-ctags
# In order to ensure +clipboard for Vim
if ! brew list | grep -q "vim"; then
  echo "Before installing vim, install dependencies from './apt.sh' (if on Linux),
run 'brew edit vim', and add the options '--with-features=huge' and '--with-x'.
Type 'Yes' to continue installation."
  read REPLY
  [[ $REPLY == "Yes" ]] && brew install --build-from-source vim
fi

