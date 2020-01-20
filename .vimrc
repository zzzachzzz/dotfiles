call plug#begin('~/.vim/plugged')
Plug 'christoomey/vim-tmux-navigator'
Plug 'talek/obvious-resize'
Plug 'preservim/nerdtree'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'natebosch/vim-lsc'
Plug 'ajh17/VimCompletesMe'
Plug 'tpope/vim-commentary'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'chrisbra/Colorizer'
Plug 'pangloss/vim-javascript'
call plug#end()

set nocompatible
set noshowmode
set termguicolors
set number
syntax on
colo custom_monokai
set cursorline
set ignorecase
set expandtab
set tabstop=2
set shiftwidth=2
set laststatus=2
set shortmess+=F
set wildmenu
set hidden
set encoding=utf8
set backspace=indent,eol,start
au BufEnter * set fo-=c fo-=r fo-=o

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

cnoremap <C-r><Leader> <C-r>+

nnoremap <Leader>a ggVG

" Windows & Tabs & Buffers
noremap <Leader>s :split<CR><C-w>J
noremap <Leader>v :vsplit<CR><C-w>L
noremap <Leader>ns :new<CR><C-w>J
noremap <Leader>nv :vnew<CR><C-w>L
noremap <Leader>w <C-w>w
noremap <Leader>J <C-w>J
noremap <Leader>K <C-w>K
noremap <Leader>H <C-w>H
noremap <Leader>L <C-w>L

" Resize windows
noremap <silent> <S-Up> :<C-U>ObviousResizeUp 5<CR>
noremap <silent> <S-Down> :<C-U>ObviousResizeDown 5<CR>
noremap <silent> <S-Left> :<C-U>ObviousResizeLeft 5<CR>
noremap <silent> <S-Right> :<C-U>ObviousResizeRight 5<CR>

noremap <Leader>t :tabedit<Space>

" FZF {{{
noremap <C-p> :Files<CR>
noremap <Leader>f :Files<CR>
noremap <Leader>b :Buffers<CR>
noremap <Leader>F :Rg<Space>

let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit' }

" Override default Rg command to behave like command line ripgrep & accept options
command! -bang -nargs=* Rg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case " . <q-args>, 1, <bang>0)
" }}}

" Comment lines with '/' (registers as '_')
noremap <C-_> :Commentary<CR>

" Vim-Airline {{{
let g:airline_powerline_fonts = 0
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 1
let g:airline#extensions#tabline#show_tabs = 1
let g:airline#extensions#tabline#show_tab_count = 1
let g:airline#extensions#tabline#tab_nr_type = 1  " Tab number
let g:airline#extensions#tabline#tabnr_formatter = 'tabnr'
let g:airline#extensions#tabline#show_tab_nr = 1
let g:airline#extensions#tabline#show_tab_type = 0
let g:airline#extensions#tabline#buf_label_first = 0
let g:airline#extensions#tabline#buffer_idx_mode = 1
let g:airline#extensions#tabline#keymap_ignored_filetypes = ['nerdtree']
let g:airline#extensions#tabline#buffer_nr_show = 0
let g:airline#extensions#tabline#show_splits = 0
let g:airline#extensions#tabline#show_close_button = 0
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline_theme = 'custom_base16_monokai'
let g:airline_section_y = '' "Get rid of the file encoding
let g:airline_section_z = '%l:%c'
" Truncate the status mode to one capital letter
let g:airline_mode_map = {
\ '__' : '-',
\ 'n'  : 'N',
\ 'i'  : 'I',
\ 'R'  : 'R',
\ 'c'  : 'C',
\ 'v'  : 'V',
\ 'V'  : 'V',
\ '^V' : 'V',
\ 's'  : 'S',
\ 'S'  : 'S',
\ '^S' : 'S',
\ }
nmap <Leader>1 <Plug>AirlineSelectTab1
nmap <Leader>2 <Plug>AirlineSelectTab2
nmap <Leader>3 <Plug>AirlineSelectTab3
nmap <Leader>4 <Plug>AirlineSelectTab4
nmap <Leader>5 <Plug>AirlineSelectTab5
nmap <Leader>6 <Plug>AirlineSelectTab6
nmap <Leader>7 <Plug>AirlineSelectTab7
nmap <Leader>8 <Plug>AirlineSelectTab8
nmap <Leader>9 <Plug>AirlineSelectTab9
nmap <Tab> <Plug>AirlineSelectNextTab
nmap <S-Tab> <Plug>AirlineSelectPrevTab
" }}}

" NerdTree {{{
noremap <Leader><Space> :NERDTreeToggle<CR>
let g:NERDTreeIgnore = ['^\.git$']
command! NTF NERDTreeFind
" }}}

set completeopt=menu,menuone,noinsert,noselect
" Vim Language Server Client (vim-lsc) {{{
let g:lsc_server_commands = {
\  'python': {
\    'command': 'pyls',
\    'log_level': -1,
\    'suppress_stderr': v:true,
\  },
\  'javascript': {
\    'command': 'typescript-language-server --stdio',
\    'log_level': -1,
\    'suppress_stderr': v:true,
\  }
\}
let g:lsc_auto_map = {
\  'GoToDefinition': '<C-]>',
\  'GoToDefinitionSplit': ['<C-W>]', '<C-W><C-]>'],
\  'FindReferences': 'gr',
\  'NextReference': '<C-n>',
\  'PreviousReference': '<C-p>',
\  'FindImplementations': 'gI',
\  'FindCodeActions': 'ga',
\  'Rename': 'gR',
\  'ShowHover': v:true,
\  'DocumentSymbol': 'go',
\  'WorkspaceSymbol': 'gS',
\  'SignatureHelp': 'gm',
\  'Completion': 'completefunc',
\}
" }}}

" Colorize
command! CH ColorHighlight

function! ToggleScrollOff999()
    if &scrolloff == 999
        set scrolloff=4
    else
        set scrolloff=999
    endif
endfunction

command! Scroll call ToggleScrollOff999()
set scrolloff=4

