scriptencoding utf-8
set encoding=utf-8
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
" Multiple Cursor
Plug 'terryma/vim-multiple-cursors'
" Javascript Syntax Highlighting and more
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'posva/vim-vue'
" Go for Vim
Plug 'jnwhiteh/vim-golang'
" Focus/Unfocus Manager
Plug 'sjl/vitality.vim'
" Syntax highlighting
Plug 'slim-template/vim-slim'
" ediitorconfig
Plug 'editorconfig/editorconfig-vim'
" xo
Plug 'sindresorhus/vim-xo'
" themes
Plug 'flazz/vim-colorschemes'
" Plug 'danilo-augusto/vim-afterglow'
Plug 't9md/vim-textmanip'
" autocomplete
Plug 'Shougo/neocomplete'
Plug 'Shougo/neocomplcache.vim'
Plug 'Shougo/neosnippet'
Plug 'Shougo/neosnippet-snippets'
Plug 'Shougo/context_filetype.vim'
Plug 'justinj/vim-react-snippets'
Plug 'itchyny/vim-cursorword'
let g:jsx_ext_required = 0
call plug#end()

" set attributes
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
set listchars=tab:__,trail:·,extends:>,precedes:<,space:·
" set nolist
set statusline="%f%m%r%h%w [%Y] [0x%02.2B]%< %F%=%4v,%4l %3p%% of %L"
set laststatus=2

" unset attributes
set nostartofline
set nowrap
set noerrorbells visualbell t_vb=
set nohlsearch

" ## REMAP COMMANDERS
set pastetoggle=<leader>p
set pastetoggle=<F12>
" remap leader
let mapleader = ','
let g:mapleader = ','

" window navigation
nnoremap <leader>, <c-w>w<CR>
nnoremap <leader>wq <c-w>q<CR>
nnoremap <leader>wn <c-w>n<CR>
nnoremap <leader>wv :vsp<CR><c-w><c-r>
nnoremap <leader>wr <c-w><c-r><CR>
"
" tab navigation
noremap <leader>tn :tabnew<CR>
noremap <leader>ta :tabprevious<CR>
noremap <leader>td :tabnext<CR>
noremap <leader>tf :tabnew<CR>:FufFile */<CR>
noremap <leader>tt :tabnew<CR>:Explore<CR>

" close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"

" buffers
nmap <leader>bb :buffers<CR>
nmap <leader>bd :bdelete<CR>
nmap <leader>x :bdelete<CR>
nmap <leader>b1 :b 1<CR>
nmap <leader>b2 :b 2<CR>
nmap <leader>b3 :b 3<CR>
nmap <leader>b4 :b 4<CR>
nmap <leader>b5 :b 5<CR>
nmap <leader>b6 :b 6<CR>
nmap <leader>b7 :b 7<CR>
nmap <leader>b8 :b 8<CR>
nmap <leader>b9 :b 9CR>

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

inoremap <leader>1 c-o>1gt
inoremap <leader>2 <c-o>2gt
inoremap <leader>3 <c-o>3gt
inoremap <leader>4 <c-o>4gt
inoremap <leader>5 <c-o>5gt
inoremap <leader>6 <c-o>6gt
inoremap <leader>7 <c-o>7gt
inoremap <leader>8 <c-o>8gt
inoremap <leader>9 <c-o>9gt
inoremap <leader>0 <c-o>:tablast<cr>

" fitting resize
autocmd VimResized * wincmd =

" eleminating whitespace before save
autocmd BufWritePre * %s/\s\+$//e

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
nnoremap <leader>s :w<CR>
inoremap <leader>s <c-o>:w<CR>
nnoremap <c-s> <ESC>:w
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
nnoremap <S-Tab> <<
nnoremap <Tab> >>
inoremap <S-Tab> <C-o><<i
vnoremap <Tab> >>
vnoremap <S-Tab> <<

" set termbg
set t_Co=282A36

" toggle show number:
nnoremap <F3> :set invnumber<CR>
inoremap <F3> <C-O>:set invnumber<CR>

" themes
" colorscheme afterglow
colorscheme minimalist

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

" ######################################################################
" ## EXTRA COMMANDS & EXTERNAL SETTINGS
" ######################################################################

" run this file with node
noremap <leader>rn :!node %<CR>

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

" fuzzy finder
nmap <leader>fd :FufDir<CR>
imap <leader>fd :FufDir<CR>
map <leader>ff :FufFile ./<CR>
nmap <leader>ff :FufFile ./<CR>
nmap <leader>fa :FufFile */<CR>
nmap <leader>fa :FufFile */<CR>
map <leader>fg :FufFile **/<CR> "massive finding
nmap <leader>fg :FufFile **/<CR> "massive finding>
map <leader>fb :FufBuffer<CR>
imap <leader>fb <C-O>:FufBuffer<CR>
imap <leader>fn :tabnew \| :FufFile ./<CR>
nmap <leader>fn :tabnew \| :FufFile ./<CR>

" netrw
nmap <leader>o :Explore<CR>
imap <leader>o <C-o>:Explore<CR>
nmap <leader>O :Vexplore<CR>
imap <leader>O <C-o>:Vexplore<CR>

let g:netrw_browse_split=0
let g:netrw_banner=0
let g:netrw_liststyle=3
let g:netrw_winsize=25
let g:netrw_preview=1
let g:netrw_alto=0

" neocomplete and neosnippets
let g:neocomplete#enable_at_startup = 1
let g:neocomplcache#min_syntax_length = 1
let g:neocomplete#auto_completion_start_length = 2
let g:neocomplete#sources#buffer#cache_limit_size = 50000
let g:neocomplete#data_directory = '~/.vim/cache/noecompl'
let g:neocomplete#enable_smart_case = 1
let g:neosnippet#snippets_directory='~/.vim/bundle/vim-snippets/snippets'
let g:acp_enableAtStartup = 0
let g:neocomplcache_enable_at_startup = 0
let g:neocomplcache_enable_smart_case = 1
let g:neocomplcache_min_syntax_length = 3

aug omnicomplete
au!
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType javascript,jsx setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType javascript,jsx setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType javascript,jsx setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
aug END

imap <expr><down> pumvisible() ? "\<C-n>" : "\<down>"

imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" textmanip
map <ESC>[5D <C-Left>
map <ESC>[5C <C-Right>
map! <ESC>[5D <C-Left>
map! <ESC>[5C <C-Right>
xmap <S-down> <Plug>(textmanip-duplicate-down)
nmap <S-down> <Plug>(textmanip-duplicate-down)
xmap <S-up> <plug>(textmanip-duplicate-up)
nmap <S-up> <Plug>(textmanip-duplicate-up)
nmap <F10> <Plug>(textmanip-toggle-mode)
xmap <F10> <Plug>(textmanip-toggle-mode)
xmap <C-down> <Plug>(textmanip-move-down)
nmap <C-down> <Plug>(textmanip-move-down)
xmap <C-up> <Plug>(textmanip-move-up)
nmap <C-up> <Plug>(textmanip-move-up)

" customize theme
hi SpecialKey ctermfg=59 ctermbg=NONE cterm=NONE guifg=#5F5F5F guibg=NONE gui=NONE
