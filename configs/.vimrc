set nocompatible
syntax enable
filetype plugin indent on

"auto-install vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall
endif

call plug#begin('~/.vim/bundle')
" HTML Handyman
Plug 'rstacruz/sparkup'
" Searching for Everywhere
Plug 'vim-scripts/L9'
Plug 'vim-scripts/FuzzyFinder'
" Editorconfig for Keeping Align
Plug 'editorconfig/editorconfig-vim'
" Surroundings Managing
Plug 'tpope/vim-surround'
" Javascript Syntax Highlighting and more
Plug 'pangloss/vim-javascript'
" Multiple Cursor
Plug 'terryma/vim-multiple-cursors'
" Go for Vim
Plug 'jnwhiteh/vim-golang'
" Grep for Vim
Plug 'vim-scripts/grep.vim'
" Focus/Unfocus Manager
Plug 'sjl/vitality.vim'
" Syntax highlighting
Plug 'slim-template/vim-slim'
" Plug 'scrooloose/nerdtree'
" Plug 'jistr/vim-nerdtree-tabs'
call plug#end()

set encoding=utf8
set showcmd
set showmode
set showmatch
set backspace=indent,eol,start
set number
set incsearch
set hlsearch
set ignorecase
set smartcase
set nostartofline
set textwidth=80

set nowrap
set textwidth=0 wrapmargin=0
set autoindent
set smartindent
set tabstop=4
set shiftwidth=4
set expandtab
set noerrorbells visualbell t_vb=
set autoread

let mapleader = ','
let g:mapleader = ','

" NERDTree
" autocmd vimenter * if !argc() | NERDTree | endi
" autocmd vimenter * if 0 | NERDTree | endi
let g:NERDChristmasTree=0
let g:NERDTreeAutoCenter=1
let g:NERDTreeHighlightCursorline=1
let g:NERDTreeHijackNetrw=0
let g:NERDTreeStatusline=1
let g:NERDTreeWinSize=20
let g:NERDTreeQuitOnOpen=0

nmap <C-k> :NERDTreeTabsToggle<CR>
imap <C-k> :NERDTreeTabsToggle<CR>

" FuzzyFinder
nmap <leader>fd :FufDir<CR>
imap <leader>fd :FufDir<CR>
map <leader>ff :FufFile */<CR>
nmap <leader>ff :FufFile */<CR>
map <leader>fa :FufFile **/<CR>
nmap <leader>fa :FufFile **/<CR>
nmap <leader>fb :FufBuffer<CR>
imap <leader>fb <C-O>:FufBuffer<CR>
nmap <leader>fn :tabnew \| :FufFile */<CR>
imap <leader>fn :tabnew \| :FufFile */<CR>

" indent for command mode
nmap <S-Tab> <<
nmap <Tab> >>
imap <S-Tab> <Esc><<i
vmap <Tab> >
vmap <S-Tab> <

" Tab commands and navigation
nmap <leader>t :tabnew<CR>
nmap <C-a> :tabprevious<CR>
imap <C-a> <ESC>:tabprevious<CR>i
nmap <C-b> :tabnext<CR>
imap <C-b> <Esc>:tabnext<CR>i
noremap <leader>a :tabprevious<CR>
noremap <leader>d :tabnext<CR>

noremap <leader>1 1gt
noremap <leader>2 2gt
noremap <leader>3 3gt
noremap <leader>4 4gt
noremap <leader>5 5gt
noremap <leader>6 6gt
noremap <leader>7 7gt
noremap <leader>8 8gt
noremap <leader>9 9gt
noremap <leader>0 :tablast<cr>

" Extend keys in visual mode
vnoremap <BS> d
vnoremap c y
vnoremap v p
vnoremap // y/<c-r>"<cr>

" Bind keys for Windows experience
nmap <C-q> :q<CR>
nmap <C-s> :w<CR>
vmap <C-s> <C-C>:w<CR>
imap <C-s> <C-O>:w<CR>
inoremap <C-z> <C-O>u
nnoremap <C-z> <C-O>u

nnoremap <leader>q :q<CR>
nnoremap <leader>s :w<CR>
nnoremap <leader>Q :qa!<CR>

" Utils
nnoremap <leader>re :source $HOME/.vimrc<CR>

" (Redefine) Window navigation
nnoremap <leader>, <c-w>w<CR>
nnoremap <leader>wq <c-w>q<CR>
nnoremap <leader>wn <c-w>n<CR>
nnoremap <leader>wv :vsp<CR><c-w><c-r>
nnoremap <leader>wr <c-w><c-r><CR>

" Cursor
nnoremap ` ^
vnoremap ` ^
nnoremap 1 $
vnoremap 1 $

" Turn on these
set nu
set ar

set pastetoggle=<leader>pp

" Cursor color
set cursorline
hi CursorLine cterm=NONE ctermbg=0 ctermfg=NONE

if exists('$ITERM_PROFILE')
    if exists('$TMUX')
        let &t_SI = "\<Esc>[3 q"
        let &t_EI = "\<Esc>[0 q"
    else
        let &t_SI = "\<Esc>]50;CursorShape=1\x7"
        let &t_EI = "\<Esc>]50;CursorShape=0\x7"
    endif
endif

" Ag
let g:ackprg = 'ag --nogroup --nocolor --column'

" Markdown
autocmd BufNewFile,BufReadPost *.md set filetype=markdown

" Multiple cursor
highlight multiple_cursors_cursor term=reverse cterm=reverse gui=reverse
highlight link multiple_cursors_visual Visual

" Diff
if &diff
highlight DiffAdd    cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
highlight DiffDelete cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
highlight DiffChange cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
highlight DiffText   cterm=bold ctermfg=10 ctermbg=88 gui=none guifg=bg guibg=Red
endif

" Run
nmap <c-r>n :!node %<cr>


let g:vitality_fix_cursor = 1
let g:vitality_fix_focus = 1
let g:vitality_always_assume_iterm = 1
