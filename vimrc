autocmd!
set t_Co=256

" pathogen config
call pathogen#infect()

set nocompatible

" enable number column and ruler (shows line,col etc)
set number
set ruler
syntax on

" enable mouse in terminal
set mouse=a

" enable current line highlighting
set cursorline
" set cursorcolumn

" hightlight column
" set colorcolumn=80

" set lines of context when scrolling
set scrolloff=5

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

" Sessions
set sessionoptions=buffers,tabpages

" hide search highlights by typing // in normal mode
noremap <silent> // :noh<CR>

set guifont=Monaco\ for\ Powerline:h13

" Tab completion
set wildmode=list:longest,list:full
set complete-=i

" include - as part of keywords, for better css-class-name tab-completion
set iskeyword+=-

" set ignores
set wildignore=*.o,*.obj,.git,*.rbc,vendor/**,tmp/**,notes/**,templates/compiled/*

" always show status bar (0=never, 1=default, 2=always)
set laststatus=2

" don't look for vim modelines in files
set nomodeline

" Turn off invisibles
set nolist

" Turn off bells
set noerrorbells
set visualbell
set t_vb=
set novb

"Directories for swp files
set backupdir=/tmp
set directory=/tmp

" folding settings
set foldmethod=indent   "fold based on indent
set foldnestmax=10      "deepest fold is 10 levels
set nofoldenable        "dont fold by default
set foldlevel=1         "this is just what i use

" =================== PLUGIN CONFIGURATION =============================
" 0 - don't manage working directory.
" 1 - the parent directory of the current file.
" 2 - the nearest ancestor that contains one of these directories or files:
let g:ctrlp_working_path_mode = 0
let g:ctrlp_use_caching = 1
let g:ctrlp_clear_cache_on_exit = 0 " do NOT clear cache on exit

" use git to list files
" let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files']
let g:ctrlp_user_command = 'find %s -type f -not -path "*.git/*"'
" let g:ctrlp_lazy_update = 1

map <Leader>f :CtrlP<CR>
map <C-t> :CtrlP<CR>

" let g:hybrid_use_Xresources = 1


" sticky-shift (http://www.linuxforums.org/forum/applications/171681-bind-capital-w-write-vim.html)
command! WQ wq
command! Wq wq
command! W w
command! Q q
command! Qa qa
command! V  tabe ~/.vimrc
command! Httpd  tabe ~/httpd.conf

" ZoomWin configuration
map <Leader>z :ZoomWin<CR>

" Expands %% to the path of the current file
" http://vim.wikia.com/wiki/Easy_edit_of_files_in_the_same_directory
cabbr %% <C-R>=expand('%:p:h')<CR>
"
" load the plugin and indent settings for the detected filetype
filetype plugin indent on

" Thorfile, Rakefile and Gemfile are Ruby
au BufRead,BufNewFile {Gemfile,Rakefile,Thorfile,config.ru}    set ft=ruby
au BufRead *.html.erb set ft=eruby.html.javascript
au BufRead *.html.erb set comments=""
au BufRead *.php      set ft=php
au BufRead *.ko       set ft=javascript.html
au BufRead *.mustache set ft=html
au BufRead *.tpl      set ft=html
au BufRead *.scss     set ft=sass
au BufRead app/views/*.php set ft=phtml
au FileType gitcommit setlocal colorcolumn=50
au FileType apache set commentstring=#\ %s

" au User Rails/app/jobs/* let b:rails_alternate = 'unit/jobs/' . rails#buffer().name()[0:-4] . '_test.rb'
" au User Rails/unit/jobs
 
" add fabrication gem support to rails.vim
au User Rails Rnavcommand fabricator test/fabricators -suffix=_fabricator.rb -default=model()

" restart apache after modifiying httpd.conf
au BufWritePost ~/httpd.conf,/etc/php.ini,/private/etc/php.ini !sudo /usr/sbin/apachectl -k restart

" restart mysql after editing config
au BufWritePost /private/etc/my.cnf !mysql.server reload

" reload this vimrc config file after saving
au BufWritePost ~/.vimrc source %

" when colorcolumn is set, use a gray color for highlighting
highlight ColorColumn ctermbg=240

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set indentkeys="0{,0},0),0],!^F,o,O,e"

" Opens a tab edit command with the path of the currently edited file filled in
" Normal mode: <Leader>te
map <Leader>te :tabe <C-R>=expand("%:p:h") . "/" <CR>

" Opens edit command with path of the currently edited file filled in
map <Leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

" bye-bye training wheels
" inoremap  <Up>     <NOP>
" inoremap  <Down>   <NOP>
" inoremap  <Left>   <NOP>
" inoremap  <Right>  <NOP>
" noremap   <Up>     <NOP>
" noremap   <Down>   <NOP>
" noremap   <Left>   <NOP>
" noremap   <Right>  <NOP>

" F3 and F4 for prev/next tab in insert and normal mode
inoremap <F3> <ESC>:tabprev<CR>
noremap <F3> <ESC>:tabprev<CR>
inoremap <F4> <ESC>:tabnext<CR>
noremap <F4> <ESC>:tabnext<CR>

" hit jj or kk in insert mode will switch back to 
" normal mode (and move the cursor 'forward' which feels right)
" inoremap jj <esc>l
" inoremap kk <esc>l

noremap <space> zz

" Highlight long lines
" highlight OverLength ctermbg=red ctermfg=white guibg=#592929
" match OverLength /\%81v.\+/

" include the matchit support for the vim-textobj-* plugins
runtime macros/matchit.vim

" eruby should fallback to using custom Html indent
" instead of using cindent.  This should hopefully provide
" better indenting of javascript in script tags of eruby
" templates
" let &l:indentexpr = 'HtmlIndentGetter(v:lnum)'

let g:notes_directory = '~/.vim/notes'

" change cursor to vertical bar in insert, block in normal
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"

" f12 toggles the Tagbar
" noremap <F12> :TagbarToggle<CR>

" typing {, [ or ( and then enter will add closing pair
" inoremap {<CR> {<CR>}<Esc>O
" inoremap (<CR> (<CR>)<Esc>O
" inoremap [<CR> [<CR>]<Esc>O

" don't auto update easytags when typing stops (it's just too laggy)
" let g:easytags_on_cursorhold = 0

" use project-specific tag files
" set tags=./tags;
" let g:easytags_dynamic_files = 1
" let g:easytags_updatetime_min = 30000 " 30 seconds

" add Pull and Push commands to invoke git
command! Pull Git pull
command! Push Git push
command! Gpull Git pull
command! Gpush Git push

" gp and gP select the last paste, in char-wise (p) or line-wise (P) mode
noremap gp `[v`]
noremap gP `[V`]

" triple = reindents file
noremap === :norm gg=G<CR>

" fancy powerline (needs terminal set to patched font)
let g:Powerline_symbols = 'fancy'

let g:syntastic_mode_map = { 'mode': 'passive', 'passive_filetypes': ['haml'], 'active_filetypes': ['html', 'js'] }

let delimitMate_expand_cr = 1
" PowerlineReloadColorscheme

" use 'the silver searcher' ag instead of ack for ack.vim
let g:ackprg = 'ag --nogroup --nocolor --column'

" Default color scheme
set background=dark
" color tir_black
" color herald
" color Tomorrow-Night-Bright
color Tomorrow-Night-Bright
" colorscheme solarized
" color jellybeans
" color lucius
" color molokai
" color hemisu

let s:ruby_deindent_keywords =
      \ '^\s*\zs\<\%(ensure\|else\|rescue\|elsif\|when\|public\|private\|protected\|end\):\@!\>'
