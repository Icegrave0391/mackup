set enc=utf-8
set nocompatible

packadd! dracula
if (has("termguicolors"))
  set termguicolors
endif
syntax enable
colorscheme codedark "dracula

" Font
" Linux 和 Windows 不同，不能用 '_' 取代空格
set guifont=DejaVu\ Sans\ Mono\ 10
"set guifont=Source\ Code\ Pro\ 11
set guifontwide=Noto\ Sans\ Mono\ CJK\ SC\ 11

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


" clipboard for windows
"set clipboard=unnamed
"set clipboard=unnamedplus

" copy (write) highlighted text to .vimbuffer
"vmap <C-c> y:new ~/.vimbuffer<CR>VGp:x<CR> \| :!cat ~/.vimbuffer \| clip.exe <CR><CR>
" paste from buffer
"map <C-v> :r ~/.vimbuffer<CR>

set relativenumber

" WSL yank support
let s:clip = '/mnt/c/Windows/System32/clip.exe'  " change this path according to your mount point
if executable(s:clip)
  augroup WSLYank
    autocmd!
    autocmd TextYankPost * if v:event.operator ==# 'y' | call system('cat |' . s:clip, @0) | endif
  augroup END
endif
" WSL paste from clipboard
"map <silent> "=p :r !powershell.exe -Command Get-Clipboard
"map! <silent> <C-r>= :r !powershell.exe -Command Get-Clipboard
"noremap "+p :exe 'norm a'.system('/mnt/c/Windows/System32/WindowsPowerShell/v1.0/powershell.exe -Command Get-Clipboard')

" minpac
if exists('*minpac#init')
  " Minpac is loaded.
  call minpac#init()
  call minpac#add('k-takata/minpac', {'type': 'opt'})
	  
  " Other plugins
  call minpac#add('tpope/vim-eunuch')
  call minpac#add('yegappan/mru')
  call minpac#add('preservim/nerdtree')
  call minpac#add('embark-theme/vim', {'name': 'embark'})
  call minpac#add('vim-airline/vim-airline')
  call minpac#add('dracula/vim', {'name': 'dracula'})
  call minpac#add('tomasiser/vim-code-dark', {'name': 'codedark'})
endif
let g:airline_theme = 'codedark'
let g:airline#extensions#tabline#enabled = 1      "tabline中当前buffer两端的分隔字符

if has('eval')
  " Minpac commands
  command! PackUpdate packadd minpac | source $MYVIMRC | call minpac#update('', {'do': 'call minpac#status()'})
  command! PackClean  packadd minpac | source $MYVIMRC | call minpac#clean()
  command! PackStatus packadd minpac | source $MYVIMRC | call minpac#status()
endif

if !has('gui_running') 
  " 设置文本菜单 
  if has('wildmenu') 
    set wildmenu 
    set cpoptions-=< 
    set wildcharm=<C-Z> 
    nnoremap <F10>       :emenu <C-Z>
    inoremap <F10> <C-O> :emenu <C-Z>
  endif
endif

" For old vim (Under 8.0)
if !has('patch-8.0.210')
  " 进入插入模式时启用括号粘贴模式
  let &t_SI .= "\<Esc>[?2004h"
  " 退出插入模式时停用括号粘贴模式
  let &t_EI .= "\<Esc>[?2004l"
  " 见到 <Esc>[200~ 就调用 XTermPasteBegin
  inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()

  function! XTermPasteBegin()
    " 设置使用 <Esc>[201~ 关闭粘贴模式
    set pastetoggle=<Esc>[201~
    " 开启粘贴模式
    set paste
    return ""
  endfunction
endif

"if v:version >= 800
"  packadd! editexisting
"endif

filetype plugin indent on
" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 4 spaces
set expandtab
