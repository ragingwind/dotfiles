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
" Muiltiple select ctrl-v/p/n/esc
Plug 'terryma/vim-multiple-cursors'
" ediitorconfig
Plug 'editorconfig/editorconfig-vim'
" xo
Plug 'sindresorhus/vim-xo'
" themes
Plug 'flazz/vim-colorschemes'
Plug 'danilo-augusto/vim-afterglow'
" autocomplete
Plug 'shougo/neocomplete.vim'
Plug 'matze/vim-move'
call plug#end()

" set attributes
set encoding=utf8
set showcmd
set showmode
set showmatch
set backspace=indent,eol,start
set number
set incsearch
set ignorecase
set smartcase
set textwidth=80
set wrapmargin=0
set autoindent
set smartindent
set tabstop=2
set shiftwidth=2
set expandtab
set autoread
set list
set listchars=eol:¸,tab:>·,trail:·,extends:>,precedes:<,space:·

" unset attributes
set nostartofline
set nowrap
set noerrorbells visualbell t_vb=
set nohlsearch

" ## REMAP COMMANDERS
set pastetoggle=<leader>p

" remap leader
let mapleader = ','
let g:mapleader = ','

" tab navigation
nmap <leader>tn :tabnew<CR>
noremap <leader>ta :tabprevious<CR>
noremap <leader>td :tabnext<CR>

" tab navigation directly
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

" page up / down
nmap <S-up> <C-u>
nmap <S-down> <C-d>

" delete selection on visual mode
vnoremap <BS> d

" copy alials
vnoremap c y

" quit and quite all
noremap <leader>q :q<CR>
nnoremap <leader>Q :qa!<CR>

" write the file
nnoremap <leader>w :w<CR>
nnoremap <leader>s :w<CR>
inoremap <c-s> <ESC>:w<CR>i

" reload cfg itself
nnoremap <leader>re :source $HOME/.vimrc<CR>

" begin of the line
nnoremap ` ^
vnoremap ` ^

" last of the line
nnoremap 1 $
vnoremap 1 $

" indent for command mode
nmap <S-Tab> <<
nmap <Tab> >>
imap <S-Tab> <Esc><<i
vmap <Tab> >
vmap <S-Tab> <

" cursor line, ctermbg=0 is none
set cursorline
hi CursorLine cterm=NONE ctermbg=darkgray ctermfg=NONE
"
" toggle show number:
nnoremap <F3> :set invnumber<CR>
inoremap <F3> <C-O>:set invnumber<CR>

" ## EXTRA COMMANDS

" run this file with node
noremap <leader>rn :!node %<CR>

" ## EXTERNAL SETTINGS

" multiple cursor
highlight multiple_cursors_cursor term=reverse cterm=reverse gui=reverse
highlight link multiple_cursors_visual Visual

" markdown autocmd
autocmd BufNewFile,BufReadPost *.md set filetype=markdown

" vitality plugin
let g:vitality_fix_cursor = 1
let g:vitality_fix_focus = 1
let g:vitality_always_assume_iterm = 1

" xo
let g:syntastic_javascript_checkers = ['xo']

" themes
colorscheme afterglow

" complete
let g:neocomplete#enable_at_startup = 1

" line move
let g:move_key_modifier = 'C'

" fixing look-and-feel
if exists('$ITERM_PROFILE')
  if exists('$TMUX')
    let &t_SI = "\<Esc>[3 q"
    let &t_EI = "\<Esc>[0 q"
  else
    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    let &t_EI = "\<Esc>]50;CursorShape=0\x7"
  endif
endif

" fuzzy finder
nmap <leader>fd :FufDir<CR>
imap <leader>fd :FufDir<CR>
map <leader>ff :FufFile ./<CR>
nmap <leader>ff :FufFile ./<CR>
nmap <leader>fa :FufFile */<CR>
nmap <leader>fa :FufFile */<CR>
map <leader>fg :FufFile **/<CR> "massive finding
nmap <leader>fg :FufFile **/<CR "massive finding>
map <leader>fb :FufBuffer<CR>
imap <leader>fb <C-O>:FufBuffer<CR>
imap <leader>fn :tabnew \| :FufFile ./<CR>
nmap <leader>fn :tabnew \| :FufFile ./<CR>


