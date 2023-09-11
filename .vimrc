" 'init.lua' is the entrypoint for neovim, which then sources this file.
" This file serves as a minimal, backwards compatible vimrc.
set nocompatible
set noshowmode
set noshowcmd
set termguicolors
set number
syntax on
let g:monokai_gui_italic = 0
try
  colo custom_monokai
catch /^Vim\%((\a\+)\)\=:E185:/
  colo evening
endtry
set cursorline
set ignorecase
set expandtab
set tabstop=2
set shiftwidth=2
set exrc
set splitbelow
set splitright
set laststatus=2
set shortmess+=F
set signcolumn=number
set wildmenu
set hidden
set encoding=utf8
set backspace=indent,eol,start
au BufEnter * set fo-=c fo-=r fo-=o
set nohlsearch
set timeoutlen=500
set history=10000

inoremap jk <Esc>
cnoremap jk <C-c>
tnoremap jk <C-\><C-n>
noremap J 5j
noremap K 5k
noremap W 5w
noremap B 5b
noremap M J
noremap 0 ^
noremap ) 0
noremap ; :
noremap q; q:
" g_ goes to end of line without newline character
noremap $ g_
noremap m `
noremap ` m
" Below is: noremap < ,
noremap <lt> ,
noremap , ;
xnoremap <Tab> >gv
xnoremap <S-Tab> <gv

let mapleader = " "

" Yank and paste using system clipboard.
noremap <Leader>y "+y
noremap <Leader>Y "+Y
noremap <Leader>p "+p
noremap <Leader>P "+P

noremap <Leader>t :tabedit<Space>
" Paste in insert and command line modes
noremap! <C-r><Leader> <C-r>+
noremap! <C-r>' <C-r>"
" Alternative for jumplist since <Tab> is mapped to AirlineSelectNextTab
nnoremap <Leader>i <Tab>
nnoremap <Leader>a ggVG
nnoremap <Leader>% :let @+ = expand("%:f")
nnoremap <silent> <Leader>; :b #<CR>
nnoremap <silent> <C-n> :cn<CR>
nnoremap <silent> <C-p> :cp<CR>

" Toggle netrw or open netrw at pwd
nnoremap <silent><expr> <Leader><Space>
  \ exists(':Rexplore') ? ':Rexplore<CR>' : ':Explore .<CR>'

" Show current file's directory in netrw
nnoremap <Leader>e :execute 'Explore' expand("%:h")<CR>

" Close buffer without closing window
command! -bang Bd bp|bd<bang> #

" Set spellfile with added words, need to call :setlocal spell
set spellfile=~/.config/nvim/spell.utf-8.add

" Enable native syntax highlight for .md files
autocmd BufNewFile,BufFilePre,BufRead *.md set filetype=markdown

" Syntax highlighting for Dockerfiles with varying filenames
autocmd BufNewFile,BufFilePre,BufRead Dockerfile* set filetype=dockerfile

" Use '//' instead of multi-line '/* */' comments
autocmd FileType c,cpp,cs,java setlocal commentstring=//\ %s

autocmd FileType cs setlocal tabstop=4 shiftwidth=4

" For quickfix list, support errorformats used by vimgrep and Telescope live_grep
autocmd FileType qf setlocal errorformat=%f\|%l\ col\ %c\|%m,%f\|%l\|\ %c\:%m
autocmd BufRead,BufNewFile *.qf set filetype=qf

" Window Splitting & Moving
noremap <Leader>s :split<CR>
noremap <Leader>v :vsplit<CR>
noremap <Leader>ns :new<CR>
noremap <Leader>nv :vnew<CR>
noremap <Leader>J <C-w>J
noremap <Leader>K <C-w>K
noremap <Leader>H <C-w>H
noremap <Leader>L <C-w>L

" Replace operation on entries in quickfix list, used after :grep
nnoremap <Leader>R
  \ :cdo s// \| update
  \<Left><Left><Left><Left><Left><Left><Left><Left><Left><Left>

function! ToggleScrollOff999()
  if &scrolloff == 999
    set scrolloff=4
  else
    set scrolloff=999
  endif
endfunction

command! Scroll call ToggleScrollOff999()
set scrolloff=4

function! TrimWhitespace()
  let l:save = winsaveview()
  keeppatterns %s/\s\+$//e
  call winrestview(l:save)
endfun

command! Trim call TrimWhitespace()

function! ConvertIndentation(from, to)
  execute 'set ts=' . a:from . ' noet'
  retab!
  execute 'set et ts=' . a:to
  retab
endfun

command! Convert4to2Spaces call ConvertIndentation(4, 2)
command! Convert2to4Spaces call ConvertIndentation(2, 4)

function! GetCmdForFiletype()
  let l:ft_runcmd = {
  \ 'javascript': 'node',
  \ 'typescript': 'node',
  \ 'python': 'python3',
  \ 'rust': 'cargo run',
  \ 'cs': 'dotnet run',
  \ }
  if &ft == 'rust' || &ft == 'cs'
    return ":!" . l:ft_runcmd[&ft]
  elseif has_key(l:ft_runcmd, &ft)
    return ":!" . l:ft_runcmd[&ft] . " %"
  else
    echoerr "No run cmd found for filetype: " . &ft
  endif
endfunction

nnoremap <expr> <Leader>B GetCmdForFiletype()

if !empty(glob("~/_vimrc"))
  source ~/_vimrc
endif

" exrc with the file name I want :)
if !empty(glob("_vimrc"))
  source _vimrc
endif
