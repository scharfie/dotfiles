set nocompatible
set t_Co=256

" enable number column and ruler (shows line,col etc)
set number
set ruler
syntax on

" Whitespace stuff
set nowrap
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set listchars="tab: ,trail: "

let mapleader=","

" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase

" Tab completion
set wildmode=list:longest,list:full
set complete-=i

" set ignores
set wildignore=*.o,*.obj,.git,*.rbc,vendor/**,tmp/**,notes/**

" always show status bar (0=never, 1=default, 2=always)
set laststatus=2

" Use modeline overrides
set modeline
set modelines=10

" Turn off invisibles
set nolist

" Turn off bells
set noerrorbells
set visualbell
set t_vb=
set novb

" Default color scheme
" color tir_black
color herald
" color jellybeans

"Directories for swp files
set backupdir=/tmp
set directory=/tmp

" =================== PLUGIN CONFIGURATION =============================
" 0 - don't manage working directory.
" 1 - the parent directory of the current file.
" 2 - the nearest ancestor that contains one of these directories or files:
let g:ctrlp_working_path_mode = 0

map <D-t> :CtrlP<CR>
map <Leader>f :CtrlP<CR>
map <C-t> :CtrlP<CR>


" pathogen config
call pathogen#infect()

" sticky-shift (http://www.linuxforums.org/forum/applications/171681-bind-capital-w-write-vim.html)
command WQ wq
command Wq wq
command W w
command Q q

" ZoomWin configuration
map <Leader>z :ZoomWin<CR>

" Expands %% to the path of the current file
" http://vim.wikia.com/wiki/Easy_edit_of_files_in_the_same_directory
cabbr %% <C-R>=expand('%:p:h')<CR>

" Thorfile, Rakefile and Gemfile are Ruby
au BufRead,BufNewFile {Gemfile,Rakefile,Thorfile,config.ru}    set ft=ruby

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" load the plugin and indent settings for the detected filetype
filetype plugin indent on

" Opens a tab edit command with the path of the currently edited file filled in
" Normal mode: <Leader>t
map <Leader>te :tabe <C-R>=expand("%:p:h") . "/" <CR>

" bye-bye training wheels
inoremap  <Up>     <NOP>
inoremap  <Down>   <NOP>
inoremap  <Left>   <NOP>
inoremap  <Right>  <NOP>
noremap   <Up>     <NOP>
noremap   <Down>   <NOP>
noremap   <Left>   <NOP>
noremap   <Right>  <NOP>

" Highlight long lines
" highlight OverLength ctermbg=red ctermfg=white guibg=#592929
" match OverLength /\%81v.\+/

" add fabrication gem support to rails.vim
autocmd User Rails Rnavcommand fabricator test/fabricators -suffix=_fabricator.rb -default=model()
