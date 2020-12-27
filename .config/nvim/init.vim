set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
if exists('g:vscode')
  source ~/.vimrc_ide
else
  source ~/.vimrc
endif

