call plug#begin('~/.vim/plugged')
Plug 'christoomey/vim-tmux-navigator'
Plug 'talek/obvious-resize'
Plug 'preservim/nerdtree'
Plug 'majutsushi/tagbar'
Plug 'ludovicchabant/vim-gutentags'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'natebosch/vim-lsc'
Plug 'ajh17/VimCompletesMe'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-obsession'
Plug 'godlygeek/tabular'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'chrisbra/Colorizer'
Plug 'pangloss/vim-javascript'
Plug 'maxmellon/vim-jsx-pretty'
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
set exrc
set splitbelow
set splitright
set laststatus=2
set shortmess+=F
set wildmenu
set hidden
set encoding=utf8
set backspace=indent,eol,start
au BufEnter * set fo-=c fo-=r fo-=o
set history=1000

imap jj <Esc>
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
noremap ' "
" Below is: noremap < ,
noremap <lt> ,
noremap , ;
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv

let mapleader = " "

" Yank and paste using system clipboard.
noremap <Leader>y "+y
noremap <Leader>Y "+Y
noremap <Leader>p "+p
noremap <Leader>P "+P
noremap <Leader>d "+d
noremap <Leader>D "+D

noremap <Leader>t :tabedit<Space>
" Paste in insert and command line modes
noremap! <C-r><Leader> <C-r>+
noremap! <C-r>' <C-r>"
" Alternative for jumplist since <C-i> / <Tab> is mapped to AirlineSelectNextTab
nnoremap <Leader>i <C-i>
nnoremap <Leader>a ggVG
nnoremap <Leader>% :let @+ = expand("%:p")
nnoremap <silent> <Leader><Tab> :b #<CR>
nnoremap <silent> <C-n> :cn<CR>
nnoremap <silent> <C-p> :cp<CR>

nnoremap <F5> :make %<<CR>

" Replace operation on files in quickfix list, used after :Rg
nnoremap <Leader>R
  \ :cfdo %s//g \| update
  \<Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left>

" Snippets {{{
" React {{{
command React echo 'React dummy command for tab completion'

command ReactComponent call ReactComponentSnippet()
function! ReactComponentSnippet()
    -1read ~/.vim/snippets/ReactComponent.jsx
    normal! 2j
    " Replace '__component__' with the file name, without the file extension
    s/__component__/\=substitute(expand('%:t'), '\..*', '', '')
endfun

command -nargs=1 ReactState call ReactStateSnippet(<q-args>)
function! ReactStateSnippet(stateVar)
    -1read ~/.vim/snippets/ReactState.jsx
    s/__state__/\=a:stateVar
    s/__state__/\=toupper(a:stateVar[0]) . a:stateVar[1:]
    normal! f)
endfun

command -nargs=1 ReactStyled call ReactStyledSnippet(<q-args>, 'ReactStyled.jsx')
command -nargs=1 ReactStyledAttrs call ReactStyledSnippet(<q-args>, 'ReactStyledAttrs.jsx')
function! ReactStyledSnippet(elementType, fileName)
    execute('-1read ~/.vim/snippets/' . a:fileName)
    s/__element__/\=toupper(a:elementType[0]) . a:elementType[1:]
    s/__element__/\=a:elementType
    normal! j
endfun
" }}}
" }}}

" Close buffer without closing window
command! -bang Bd bp|bd<bang> #

" Enable native syntax highlight for .md files
autocmd BufNewFile,BufFilePre,BufRead *.md set filetype=markdown

" Window Splitting & Moving
noremap <Leader>s :split<CR>
noremap <Leader>v :vsplit<CR>
noremap <Leader>ns :new<CR>
noremap <Leader>nv :vnew<CR>
noremap <Leader>J <C-w>J
noremap <Leader>K <C-w>K
noremap <Leader>H <C-w>H
noremap <Leader>L <C-w>L

" Resize windows
noremap <silent> <S-Up> :<C-U>ObviousResizeUp 5<CR>
noremap <silent> <S-Down> :<C-U>ObviousResizeDown 5<CR>
noremap <silent> <S-Left> :<C-U>ObviousResizeLeft 5<CR>
noremap <silent> <S-Right> :<C-U>ObviousResizeRight 5<CR>

" FZF {{{
noremap <Leader>f :Files<CR>
noremap <Leader>b :Buffers<CR>
noremap <Leader>F :Rg<Space>
noremap <Leader>r :BTags<CR>

let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit' }

" Override default Rg command to behave like command line ripgrep & accept options
command! -bang -nargs=* Rg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case " . <q-args>, 1, <bang>0)
" }}}

" Vim-Commentary {{{
" Comment lines with '/' (registers as '_')
noremap <C-_> :Commentary<CR>
" Use '//' instead of multi-line '/* */' for C++ comments
autocmd FileType c,cpp,cs,java setlocal commentstring=//\ %s
" }}}

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
let g:airline_section_x = '%{tagbar#currenttag("%s", "", "")}'
let g:airline_section_y = '%{ObsessionStatus()}'
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
let g:NERDTreeIgnore = ['^\.git$', '^node_modules$', '^.*\.pyc$', '^__pycache__$']
command NTF NERDTreeFind
" }}}

" Tagbar
noremap <Leader>l :TagbarToggle<CR>

" Gutentags
let g:gutentags_file_list_command = "rg --files --ignore-file $HOME/.ignore --glob '!*.json' --glob !'*.yaml'"

" VimCompletesMe
autocmd FileType css,scss let b:vcm_tab_complete = 'omni'
set completeopt=menu,menuone,noinsert,noselect

" Vim Language Server Client (vim-lsc) {{{
let g:lsc_server_commands = {}
if executable('pyls')
  call extend(g:lsc_server_commands, {
  \  'python': {
  \    'command': 'pyls',
  \    'log_level': -1,
  \    'suppress_stderr': v:true,
  \  },
  \})
endif
if executable('typescript-language-server')
  call extend(g:lsc_server_commands, {
  \  'javascript': {
  \    'command': 'typescript-language-server --stdio',
  \    'log_level': -1,
  \    'suppress_stderr': v:true,
  \  },
  \  'javascriptreact': {
  \    'command': 'typescript-language-server --stdio',
  \    'log_level': -1,
  \    'suppress_stderr': v:true,
  \  },
  \  'typescript': {
  \    'command': 'typescript-language-server --stdio',
  \    'log_level': -1,
  \    'suppress_stderr': v:true,
  \  },
  \  'typescriptreact': {
  \    'command': 'typescript-language-server --stdio',
  \    'log_level': -1,
  \    'suppress_stderr': v:true,
  \  },
  \})
endif
if executable('clangd')
  call extend(g:lsc_server_commands, {
  \  'cpp': {
  \    'command': 'clangd',
  \    'log_level': -1,
  \    'suppress_stderr': v:true,
  \  },
  \})
endif
let g:lsc_auto_map = {
\  'GoToDefinition': '<C-]>',
\  'GoToDefinitionSplit': ['<C-w>]', '<C-w><C-]>'],
\  'FindReferences': 'gr',
\  'FindImplementations': 'gI',
\  'FindCodeActions': 'ga',
\  'Rename': 'gR',
\  'ShowHover': 'gh',
\  'DocumentSymbol': 'go',
\  'WorkspaceSymbol': 'gS',
\  'SignatureHelp': 'gm',
\  'Completion': 'completefunc',
\}
" }}}

" Colorize
command CH ColorHighlight

" Vim-Obsession & session loading
nnoremap <Leader>o :Obsess<Space>~/.vim/sessions/
nnoremap <Leader>O :so<Space>~/.vim/sessions/

function! ToggleScrollOff999()
    if &scrolloff == 999
        set scrolloff=4
    else
        set scrolloff=999
    endif
endfunction

command Scroll call ToggleScrollOff999()
set scrolloff=4

function! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun

command Trim call TrimWhitespace()

