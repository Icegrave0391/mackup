set enc=utf-8
set nocompatible

" Font
" Linux 和 Windows 不同，不能用 '_' 取代空格
set guifont=DejaVu\ Sans\ Mono\ 10
set guifontwide=Noto\ Sans\ Mono\ CJK\ SC\ 11


" Cache
set nobackup
set undodir=~/.vim/undodir
if !isdirectory(&undodir)
  call mkdir(&undodir, 'p', 0700)
  endif

" load menu
let do_syntax_sel_menu = 1
" no lazyload
let do_no_lazyload_menus = 1

if has('mouse')
  if has('gui_running') || (&term =~ 'xterm' && !has('mac'))
    set mouse=a
  else
    set mouse=nvi
  endif
endif


