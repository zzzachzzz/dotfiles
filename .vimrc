set number
syntax on
colo monokai_custom
set ignorecase
set expandtab
set tabstop=2
set shiftwidth=2
set laststatus=2
set statusline=\ %F
set shortmess+=F

imap jj <Esc>
noremap J 5j
noremap K 5k
noremap W 5w
noremap B 5b
noremap M J
noremap 0 ^
noremap ) 0
noremap ; :
" g_ goes to end of line without newline character
noremap $ g_
noremap m `
noremap ` m
noremap ' "
noremap q @
noremap @ q
noremap qq @@
" Below is: noremap < ,
noremap <lt> ,
noremap , ;
noremap <C-s> :w<CR>
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv

" .neovintageousrc needs <Space>
let mapleader="<Space>"
" No effect in Neovintageous
if 1
    let mapleader = " "
" Neovintageous specific (can't indent)
else
noremap <Leader><Tab> :NextViewInStack<CR>
noremap <Leader>j :PrevView<CR>
noremap <Leader>k :NextView<CR>
noremap <Leader>h :FocusGroup group=0<CR>
noremap <Leader>l :FocusGroup group=1<CR>
endif

" Yank and paste using system clipboard.
noremap <Leader>y "+y
noremap <Leader>Y "+Y
noremap <Leader>p "+p
noremap <Leader>P "+P
noremap <Leader>d "+d
noremap <Leader>D "+D

nnoremap <Leader>a ggVG

" Windows & Tabs
nmap <Leader>s :split<CR><C-w>w
nmap <Leader>v :vsplit<CR><C-w>w
nmap <Leader>w <C-w>w
nmap <Leader>j <C-w>j
nmap <Leader>k <C-w>k
nmap <Leader>h <C-w>h
nmap <Leader>l <C-w>l
nmap <Leader>t :tabedit
nmap <Tab> :tabnext<CR>
nmap <S-Tab> :tabprev<CR>

call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-commentary'
Plug 'pangloss/vim-javascript'
call plug#end()

