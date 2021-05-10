call plug#begin('~/.vim/plugged')
Plug 'christoomey/vim-tmux-navigator'
Plug 'talek/obvious-resize'
Plug 'preservim/nerdtree'
Plug 'majutsushi/tagbar'
Plug 'ludovicchabant/vim-gutentags'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'SirVer/ultisnips'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-surround'
Plug 'godlygeek/tabular'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'chrisbra/Colorizer'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'maxmellon/vim-jsx-pretty'
call plug#end()

set nocompatible
set noshowmode
set noshowcmd
set termguicolors
set number
syntax on
let g:monokai_gui_italic = 0
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
set nohlsearch
set history=10000

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
xnoremap <Tab> >gv
xnoremap <S-Tab> <gv

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
" Alternative for jumplist since <Tab> is mapped to AirlineSelectNextTab
nnoremap <Leader>i <Tab>
nnoremap <Leader>a ggVG
nnoremap <Leader>% :let @+ = expand("%:f")
nnoremap <silent> <Leader><Tab> :b #<CR>
nnoremap <silent> <C-n> :cn<CR>
nnoremap <silent> <C-p> :cp<CR>

nnoremap <F5> :make %<<CR>

" Close buffer without closing window
command! -bang Bd bp|bd<bang> #

" Spell check & file of added words
autocmd FileType markdown,gitcommit setlocal spell
set spellfile=~/.vim/spell.utf-8.add

" Enable native syntax highlight for .md files
autocmd BufNewFile,BufFilePre,BufRead *.md set filetype=markdown

" Syntax highlighting for Dockerfiles with varying filenames
autocmd BufNewFile,BufFilePre,BufRead Dockerfile* set filetype=dockerfile

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
command! -bang -nargs=* Rg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case --type-add 'js:*.{js,ts,jsx,tsx}' " . <q-args>, 1, <bang>0)

  " Replace operation on entries in quickfix list, used after :Rg
  nnoremap <Leader>R
    \ :cdo s// \| update
    \<Left><Left><Left><Left><Left><Left><Left><Left><Left><Left>
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
command! NTF NERDTreeFind
" }}}

" Tagbar
noremap <Leader>l :TagbarToggle<CR>

" Gutentags
let g:gutentags_file_list_command = "rg --files --ignore-file $HOME/.ignore --glob '!*.json' --glob !'*.yaml'"

" UltiSnips {{{
let g:UltiSnipsSnippetDirectories = ['~/.vim/UltiSnips/']
let g:UltiSnipsExpandTrigger = '<C-y>'
let g:UltiSnipsJumpForwardTrigger = '<Tab>'
let g:UltiSnipsJumpBackwardTrigger = '<S-Tab>'
autocmd FileType typescript,javascriptreact,typescriptreact
  \ UltiSnipsAddFiletypes javascript
" }}}

" coc-nvim {{{
let g:coc_global_extensions = [
  \ 'coc-snippets',
  \ 'coc-tsserver'
  \]

set nobackup
set nowritebackup
set updatetime=300
set shortmess+=c
set signcolumn=no

inoremap <silent><expr> <TAB>
  \ pumvisible() ? "\<C-n>" :
  \ <SID>check_back_space() ? "\<TAB>" :
  \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
inoremap <silent><expr> <C-a> coc#refresh()
nnoremap <silent><nowait><expr> <C-f> coc#float#has_float() ? coc#float#scroll(1) : "\<C-f>"
nnoremap <silent><nowait><expr> <C-b> coc#float#has_float() ? coc#float#scroll(0) : "\<C-b>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

call coc#config('suggest', {
  \ 'autoTrigger': 'none'
  \})
call coc#config('snippets.extends', {
  \ 'typescript': ['javascript'],
  \ 'typescriptreact': ['javascript'],
  \ 'javascriptreact': ['javascript'],
  \})

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gh :call <SID>show_documentation()<CR>
nmap <silent> gtd <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap gR <Plug>(coc-rename)
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
nmap gac <Plug>(coc-codeaction)
nmap gqf <Plug>(coc-fix-current)
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

command! OrganizeImports :call CocAction('runCommand', 'editor.action.organizeImport')
" }}}

" Colorize
command! CH ColorHighlight

" Vim-Obsession session saving & session loading
nnoremap <Leader>O :Obsess<Space>~/.vim/sessions/
nnoremap <Leader>o :so<Space>~/.vim/sessions/

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

