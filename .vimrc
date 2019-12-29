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
set nocompatible
set wildmenu

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

" Windows & Tabs & Buffers
noremap <Leader>s :split<CR><C-w>J
noremap <Leader>v :vsplit<CR><C-w>L
noremap <Leader>ns :new<CR><C-w>J
noremap <Leader>nv :vnew<CR><C-w>L
noremap <Leader>w <C-w>w
noremap <Leader>j <C-w>j
noremap <Leader>k <C-w>k
noremap <Leader>h <C-w>h
noremap <Leader>l <C-w>l
noremap <Leader>J <C-w>J
noremap <Leader>K <C-w>K
noremap <Leader>H <C-w>H
noremap <Leader>L <C-w>L
noremap <Leader>t :tabedit<Space>
noremap <Tab> :bnext<CR>
noremap <S-Tab> :bprev<CR>
noremap <Leader><Tab> :tabnext<CR>
noremap <Leader><S-Tab> :tabprev<CR>
noremap <Leader>1 1gt
noremap <Leader>2 2gt
noremap <Leader>3 3gt
noremap <Leader>4 4gt
noremap <Leader>5 5gt
noremap <Leader>6 6gt
noremap <Leader>7 7gt
noremap <Leader>8 8gt
noremap <Leader>9 9gt
noremap <Leader>0 :tablast<CR>

" FZF
noremap <C-p> :Files<CR>
noremap <Leader>ls :Buffers<CR>

" Comment lines with '/' (registers as '_')
vmap <C-_> :Commentary<CR>
nmap <C-_> :Commentary<CR>

call plug#begin('~/.vim/plugged')
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-commentary'
Plug 'pangloss/vim-javascript'
call plug#end()

