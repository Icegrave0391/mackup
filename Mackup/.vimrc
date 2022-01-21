set enc=utf-8
set nocompatible

" Color scheme
packadd! dracula
colorscheme dracula "codedark

" Tmux color
if exists('$TMUX')
    " Colors in tmux
    let &t_8f = "<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "<Esc>[48;2;%lu;%lu;%lum"
endif
if (has("termguicolors"))
    set termguicolors
endif
set background=dark

" Enable transparent background
"hi Normal guibg=NONE ctermbg=NONE
"highlight clear CursorLineNR

" Enable syntax highlighting
syntax on
" Highlight current line
" set cursorline
" Highlight searches
set hlsearch
" Ignore case of searches
set ignorecase
" Enable line numbers
set number
"set rnu
"set relativenumber

filetype plugin indent on
" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 4 spaces
set expandtab

" Font
"set guifont=DejaVu\ Sans\ Mono\ 10
"set guifont=Source\ Code\ Pro\ 11
"set guifontwide=Noto\ Sans\ Mono\ CJK\ SC\ 11

" Cache
set nobackup
set undodir=~/.vim/undodir
if !isdirectory(&undodir)
    call mkdir(&undodir, 'p', 0700)
endif

" Mouse
if has('mouse')
    if has('gui_running') || (&term =~ 'xterm' && !has('mac'))
        set mouse=a
    else
        set mouse=nvi
  endif
endif

" Chinese
set fileencodings=ucs-bom,utf-8,gb18030,latin1

" load menu
let do_syntax_sel_menu = 1
" no lazyload
let do_no_lazyload_menus = 1

" OS specified features
if has("mac")
    "Mac

    " clipboard for mac
    set clipboard=unnamed
elseif has("win32")
   "all Windows, ie win32,win64
elseif has("win32unix")
    "Cygwin
elseif has("bsd")
    "BSD-based, ie freeBSD"
elseif has("linux")
    "Linux
    set clipboard=unnamedplus

elseif has("unix")
    let lines = readfile("/proc/version")
    if lines[0] =~ "WSL"
        " WSL

        " WSL yank support
        let s:clip = '/mnt/c/Windows/System32/clip.exe'  " change this path according to your mount point
        if executable(s:clip)
            augroup WSLYank
                autocmd!
                autocmd TextYankPost * if v:event.operator ==# 'y' | call system('cat |' . s:clip, @0) | endif
            augroup END
        endif
    endif
endif



" copy (write) highlighted text to .vimbuffer
"vmap <C-c> y:new ~/.vimbuffer<CR>VGp:x<CR> \| :!cat ~/.vimbuffer \| clip.exe <CR><CR>
" paste from buffer
"map <C-v> :r ~/.vimbuffer<CR>

" minpac
if exists('*minpac#init')
    " Minpac is loaded.
    call minpac#init()
    call minpac#add('k-takata/minpac', {'type': 'opt'})

    " Other plugins
    call minpac#add('tpope/vim-eunuch')
    call minpac#add('preservim/nerdtree')
    call minpac#add('vim-airline/vim-airline')
    call minpac#add('embark-theme/vim', {'name': 'embark'})
    call minpac#add('dracula/vim', {'name': 'dracula'})
    call minpac#add('tomasiser/vim-code-dark', {'name': 'codedark'})
    call minpac#add('tpope/vim-surround')
endif
let g:airline_theme = 'dracula' "'codedark'
let g:airline#extensions#tabline#enabled = 1      "tabline中当前buffer两端的分隔字符
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" unicode symbols
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.colnr = ' ㏇:'
let g:airline_symbols.colnr = ' ℅:'
let g:airline_symbols.crypt = '🔒'
let g:airline_symbols.linenr = '☰'
let g:airline_symbols.linenr = ' ␊:'
let g:airline_symbols.linenr = ' ␤:'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.maxlinenr = '㏑'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.spell = 'Ꞩ'
let g:airline_symbols.notexists = 'Ɇ'
let g:airline_symbols.whitespace = 'Ξ'

" powerline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.colnr = ' :'
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ' :'
let g:airline_symbols.maxlinenr = '☰ '
let g:airline_symbols.dirty='⚡'


if has('eval')
    " Minpac commands
    command! PackUpdate packadd minpac | source $MYVIMRC | call minpac#update('', {'do': 'call minpac#status()'})
    command! PackClean  packadd minpac | source $MYVIMRC | call minpac#clean()
    command! PackStatus packadd minpac | source $MYVIMRC | call minpac#status()
endif

