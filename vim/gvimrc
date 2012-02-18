" let delimitMate_smart_matchpairs = ''

if has("gui_running")
  " Disable the useless balloon tooltips that bog down the system
  set noballooneval

  set guifont=Monospace\ 16
  " map <C-/> <plug>NERDCommenterToggle<CR>
  set transparency=10
  " source $VIMRUNTIME/mswin.vim
  " behave mswin
  "
  " default to fullscreen
  " set fu
endif

if has("gui_macvim")
  " Font
  " set guifont=Inconsolata:h18
  set guifont=Panic\ Sans:h12

  " Fullscreen takes up entire screen
  set fuoptions=maxhorz,maxvert

  " Command-T for ctrlp.vim
  macmenu &File.New\ Tab key=<nop>
  map <D-t> :CtrlP<CR>

  " Command-Shift-F for Ack
  macmenu Window.Toggle\ Full\ Screen\ Mode key=<nop>
  map <D-F> :Ack<space>

  " Command-/ to toggle comments
  map <D-/> <plug>NERDCommenterToggle<CR>
endif

" Start without the toolbar
set guioptions-=T

" Turn off scrollbars
set guioptions-=L
set guioptions-=r

" enable ragtag everywhere
let g:ragtag_global_maps = 1
