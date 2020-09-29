" vimrc file
" Maintainer: David Weir <dmw109@pitt.edu>
" Last change:  9/29/2020

" Type :so % to refresh .vimrc after making a change.
" Insert a finish command to add script breakpoints for debugging

" Leader - (\)
"let mapleader="\"
nnoremap <silent><leader>v :e ~/.vimrc<CR>
" Environment {{{
if !has('nvim')
	set runtimepath=$XDG_CONFIG_HOME/vim,$XDG_CONFIG_HOME/vim/after,$VIM,$VIMRUNTIME
	let $MYVIMRC="$~/.vimrc"
endif
" }}}
 " UI Config {{{ 
set nocompatible                " use Vim settings, rather than Vi.
set backspace=indent,eol,start  " allow backspacing over everything in insert mode
set mouse=a                     " use mouse
set history=50                  " keep 50 lines of command line history
set ruler                       " show the cursor position all the time
set showcmd                     " display incomplete commands
set nocursorline                  " highlight current line
set nocursorcolumn
set number relativenumber       " show relative line numbers
set showmatch                   " highlight matching [{()}]
set splitright                  " open new vsplit panes to right
set splitbelow                  " open new split panes below
set laststatus=2
set nowrap
" Auto resize Vim splits to active split
" set winwidth=104
" set winheight=5
" set winminheight=5
" set winheight=999
set noerrorbells
set belloff=all

set guioptions-=m  "remove menu bar
set guioptions-=T  "remove toolbar
set guioptions-=r  "remove right-hand scroll bar
set guioptions-=L  "remove left-hand scroll bar
set guioptions-=e
set guifont=Source_Code_Pro_Medium:h10

" Scrolling
set scrolloff=8             "Start scrolling 8 away from margins
set sidescrolloff=15
set sidescroll=1
"}}}
" Optional Packages.{{{
"
" The matchit plugin makes the % command work better, but it is not backwards
" compatible.
packadd! matchit

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-rsi'
Plugin 'tpope/vim-vinegar'

Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'

Plugin 'mattn/emmet-vim'

Plugin 'zirrostig/vim-schlepp'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'Raimondi/delimitMate'
Plugin 'AndrewRadev/splitjoin.vim'

Plugin 'machakann/vim-highlightedyank'
Plugin 'wellle/targets.vim'

" Color Schemes
Plugin 'notpratheek/vim-luna'
Plugin 'danilo-augusto/vim-afterglow'
Plugin 'ayu-theme/ayu-vim'
Plugin 'morhetz/gruvbox'
Plugin 'juanedi/predawn.vim'
Plugin 'NLKNguyen/papercolor-theme'
Plugin 'tomasiser/vim-code-dark'
Plugin 'huyvohcmc/atlas.vim'
Plugin 'Lokaltog/vim-monotone'

call vundle#end()

" }}}
" Colors {{{ 
:syntax enable "Get Color
set background=dark
hi link matlabComma Normal
hi link matlabSemicolon Normal
" let g:gruvbox_invert_selection=0
" let g:gruvbox_contrast_dark='hard'
" hi Visual guibg=#3c3836
" colorscheme gruvbox

" let g:monotone_color = [80, 58, 60] " Sets theme color to bright green
" let g:monotone_secondary_hue_offset = 200 " Offset secondary colors by 200 degrees
" let g:monotone_emphasize_comments = 0 " Emphasize comments
" colorscheme monotone

" let g:afterglow_inherit_background=1
" colorscheme afterglow

set termguicolors     " enable true colors support
" let ayucolor="light"  " for light version of theme
" let ayucolor="mirage" " for mirage version of theme
" let ayucolor="dark"   " for dark version of theme
colorscheme codedark

" }}}
" Quick Fix {{{
"Close quickfix/location window
nnoremap <leader>c :cclose<bar>lclose<cr>
" }}}
" Netrw {{{
let g:netrw_banner=0            " disable banner text
let g:netrw_browse_split=0      " open in prior window
let g:netrw_altv=1              " open splits to the right
let g:netrw_liststyle=0         " tree view
let g:netrw_preview=1           " preview file in a vertical split by default
let g:netrw_winsize=20          " use 20% of windows for browser when previewing a file
let g:netrw_fastbrowse=1
" let g:netrw_sort_by='name'
let g:netrw_sort_direction='normal'

nnoremap <leader><leader> :Lexplore<cr>
" }}}  
" ctags {{{
set tags+=./tags;~
map <C-\> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>
" }}}
" Terminal {{{
nnoremap <silent><leader><CR> :term ++close bash.exe<CR><C-W>L
nnoremap <silent><leader>t :term ++close bash.exe<CR><C-W>J
nnoremap <silent><leader>g :term ++close bash.exe<CR><C-W>Lgit status<CR>
" }}}
" AutoGroups {{{
" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") >= 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

	"Auto change directory
	autocmd BufEnter * silent! lcd %:p:h

endif " has("autocmd")
" }}}
" Searching {{{
set nohls           " no hightlight search
set wildmenu        " visual autocomplete for command menu
set wildignore+=*/tmp/*,*.swp,*.zip,*.exe,*.so,NTUSER*,ntuser.*
set incsearch       " do incremental searching
set showmatch       " highlight matching [{()}]
set path+=**
set gdefault        " make global search default
set ignorecase      " ignore case of search
set smartcase       " override ignorecase if the search pattern contains uppercase
set magic
nnoremap <Space> :set hlsearch!<CR>
" }}}
" Save/Quit {{{

" Save
inoremap <C-s>     <C-O>:update<cr>
nnoremap <C-s>     :update<cr>
nnoremap <leader>s :update<cr>
nnoremap <leader>w :update<cr>

" Quit
inoremap <C-Q>     <esc>:q<cr>
nnoremap <C-Q>     :q<cr>
vnoremap <C-Q>     <esc>
nnoremap <Leader>q :q<cr>
nnoremap <Leader>Q :qa!<cr>

nnoremap <leader>cd :cd %:p:h<CR>:pwd<CR>
" }}}
" Folding {{{
set foldenable          " enable folding
set foldlevelstart=10   " open most folds by default
set foldnestmax=10      " maximum number of folds allowed
set foldmethod=indent   " fold based on indent level

" }}}
" Backups {{{
set noswapfile
set nobackup
"set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp/,/tmp
"set backupskip=/tmp/*,/private/tmp/*
"set directory=~/.vim-tmp,~/.tmp,/var/tmp,/tmp
set nowritebackup
" }}}
"Line Shortcuts  {{{
" Move current line up or down
nnoremap <S-Up> :m-2<CR>==
nnoremap <S-Down> :m+<CR>==
inoremap <S-Up> <Esc> :m-2<CR>==gi
inoremap <S-Down> <Esc> :m+<CR>==gi

" Make Y yank from cursor to end of line
:map Y y$

" Open new lines without entering insert mode
nmap gO mmO<ESC>j`m
nmap go mmo<ESC>k`m

"}}}
" Visual Shortcuts {{{
" highlight last inserted text
nnoremap gV `[v`]

"}}}
" Movement Shortcuts {{{
" Disable Arrow Keys
nmap <UP> <NOP>
nmap <DOWN> <NOP>
nmap <LEFT> <NOP>
nmap <RIGHT> <NOP>

imap <UP> <NOP>
imap <DOWN> <NOP>
imap <LEFT> <NOP>
imap <RIGHT> <NOP>

" Quicker window movement
" nnoremap <C-j> <C-w>j
" nnoremap <C-k> <C-w>k
" nnoremap <C-h> <C-w>h
" nnoremap <C-l> <C-w>l

" Quicker Buffer Movement
nnoremap <Tab> :bn<CR>
nnoremap <S-Tab> :bp<CR>

"Auto Center on movements
nmap G Gzz
nmap n nzz
nmap N Nzz
nmap } }zz
nmap { {zz

" }}}
" Window Shortcuts {{{
nnoremap <silent><C-w>n :vne<CR>
nnoremap gb :ls<CR>:buffer<Space>
nnoremap <C-j> <C-e>
nnoremap <C-k> <C-y>
"}}}
" Spaces & Tabs {{{
set nolist
set tabstop=4                   "Number of visual spaces per TAB
set softtabstop=4               "Number of spaces tab counts for when editing
"set expandtab                  Turn tabs into spaces
set shiftwidth=4                "Whitespace shift amount in spaces
" }}}
"  Abbreviations {{{
iabbr Ture True
iabbr ture true
iabbr Flase False
iabbr flase false
iabbr teh the
iabbr fucntion function
iabbr funtcion function
iabbr fucn func

"  }}}
" DelimitMate {{{
let g:delimitMate_expand_cr = 1
"}}}
" Schlepp {{{
vmap <up>    <Plug>SchleppUp
vmap <down>  <Plug>SchleppDown
vmap <left>  <Plug>SchleppLeft
vmap <right> <Plug>SchleppRight
" }}}
" FZF {{{
nnoremap <silent> <Leader>c     :Colors<CR>
nnoremap <silent> <Leader>b		:Buffers<CR>
nnoremap <silent> <Leader>l     :Lines<CR>
nnoremap <silent> <Leader>f     :Files<CR>
nnoremap <silent> <Leader>`		:Marks<CR>

" Mapping selecting mappings
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

" Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file)
imap <c-x><c-l> <plug>(fzf-complete-line)

" Advanced customization using autoload functions
inoremap <expr> <c-x><c-k> fzf#vim#complete#word({'left': '15%'})
" }}}
" Targets {{{
let g:targets_seekRanges = 'cc cr lr'
" }}}
" Yank Highlight {{{
let g:highlightedyank_highlight_duration = 500		"ms
highlight HighlightedyankRegion cterm=reverse gui=reverse
" }}}
set modelines=1
" vim:foldmethod=marker:foldlevel=0:
