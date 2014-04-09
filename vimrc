set background=dark
color base16-default

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

" large preview window
set previewheight=24

" Whitespace stuff
set nowrap
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set listchars="tab: ,trail: "

" remove comment character when joining lines
set formatoptions+=j

" let mapleader="\<Space>"
let mapleader=","

" Searching
" highlight search results
set hlsearch

" highlight and jump to first result while typing
set incsearch
set ignorecase
set smartcase

" Sessions
set sessionoptions=buffers,tabpages

" hide search highlights by typing // in normal mode
noremap <silent> // :noh<CR>

" begin easy align from visual mode by pressing enter
vnoremap <silent> <Enter> :EasyAlign<Enter>

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

" buffers
set hidden

" indenting
set smartindent
set autoindent

" =================== PLUGIN CONFIGURATION =============================
" 0 - don't manage working directory.
" 1 - the parent directory of the current file.
" 2 - the nearest ancestor that contains one of these directories or files:
let g:ctrlp_working_path_mode = 0
let g:ctrlp_use_caching = 1
let g:ctrlp_clear_cache_on_exit = 0 " do NOT clear cache on exit

if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

" use git to list files
" let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files']
" let g:ctrlp_user_command = 'cd %s && find . -type f -not -path "*.log" -not -path "*.git/*" -not -path "./tmp/*" -not -path "./public_local/*" -not -path "./public/system/*"'
" let g:ctrlp_lazy_update = 1

map <Leader>f :CtrlP<CR>
map <Leader>o :CtrlP<CR>
map <C-t> :CtrlP<CR>

map <Leader>gw :w<CR>
map <Leader>w :w<CR>
map <Leader>q :q<CR>

" let g:hybrid_use_Xresources = 1


" sticky-shift (http://www.linuxforums.org/forum/applications/171681-bind-capital-w-write-vim.html)
command! WQ wq
command! Wq wq
command! W w
command! Q q
command! Qa qa
command! Vimrc  tabe ~/.vimrc
command! Httpd  tabe ~/httpd.conf
command! FixCR  :%s//\r/g

command! -nargs=+ Gcm Gcommit -a -m 

map <Leader>z :Bonly<CR>:tabonly<CR>

" Expands %% to the path of the current file
" http://vim.wikia.com/wiki/Easy_edit_of_files_in_the_same_directory
cabbr %% <C-R>=expand('%:p:h')<CR>
"
" load the plugin and indent settings for the detected filetype
filetype plugin indent on

" Thorfile, Rakefile and Gemfile are Ruby
au BufRead,BufNewFile {Gemfile,Rakefile,Thorfile,config.ru}    set ft=ruby
au BufRead {*.conf}   set ft=apache
au BufRead *.html.erb set ft=eruby.html.javascript
au BufRead *.html.erb set comments=""
au BufRead *.php      set ft=php
au BufRead *.ko       set ft=javascript.html
au BufRead *.mustache set ft=html
au BufRead *.tpl      set ft=html
au BufRead *.scss     set ft=scss
au BufRead app/views/*.php set ft=phtml
au BufRead *.thtml set ft=phtml
au BufRead *.json.erb set ft=json
au FileType gitcommit setlocal colorcolumn=50
au FileType apache set commentstring=#\ %s
au FileType changelog set expandtab

" au User Rails/app/jobs/* let b:rails_alternate = 'unit/jobs/' . rails#buffer().name()[0:-4] . '_test.rb'
" au User Rails/unit/jobs
 
" add fabrication gem support to rails.vim
au User Rails Rnavcommand fabricator test/fabricators -suffix=_fabricator.rb -default=model()

let g:rails_projects = {
      \ "config/routes.rb": {
      \ "command": "routes"
      \ }
      \}

" recreate sites.conf after modifying sites.conf.rb
au BufWritePost ~/httpd/sites.conf.rb !ruby ~/httpd/sites.conf.rb

" restart apache after modifiying httpd.conf
au BufWritePost *.conf,/etc/php.ini,/private/etc/php.ini !sudo /usr/sbin/apachectl -k restart

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
runtime! macros/matchit.vim

" eruby should fallback to using custom Html indent
" instead of using cindent.  This should hopefully provide
" better indenting of javascript in script tags of eruby
" templates
" let &l:indentexpr = 'HtmlIndentGetter(v:lnum)'

let g:notes_directory = '~/.vim/notes'

let g:ruby_indent_access_modifier_style = 'outdent'

" change cursor 
" where N=0, 1, or 2.
" 0: Block
" 1: Vertical bar
" 2: Underline
" t_SI is for insert mode
" t_EI is for normal mode
let &t_SI = "\<Esc>]50;CursorShape=2\x7"
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

" function! GcmFromLog()
"   normal "myy
"   " exec 'Git status'
"   " exec 'Gcommit'
"   normal "mP^
" endfunction

" gp and gP select the last paste, in char-wise (p) or line-wise (P) mode
noremap gp `[v`]
noremap gP `[V`]

" triple = reindents file
noremap === :norm gg=G``zz<CR>

let g:promptline_theme   = 'airline'
let g:promptline_symbols = {
    \ 'left'       : '⮀',
    \ 'left_alt'   : '⮁',
    \ 'right'      : '⮂',
    \ 'right_alt'  : '⮃',
    \ 'dir_sep'    : '/',
    \ 'truncation' : '⋯',
    \ 'vcs_branch' : '⭠ ',
    \ 'space'      : ' ' }

let g:promptline_preset = {
        \'a' : [ '★', promptline#slices#battery({'threshold': 25}) ],
        \'b' : [  ],
        \'c' : [ promptline#slices#cwd({'dir_limit': 2})  ],
        \'x' : [ promptline#slices#jobs() ],
        \'y' : [ promptline#slices#vcs_branch() ],
        \'warn' : [ promptline#slices#last_exit_code() ],
        \'options': {
          \'left_sections': ['a', 'c', 'y'],
          \'right_sections': ['x'] } }


" fancy powerline (needs terminal set to patched font)
let g:Powerline_symbols = 'fancy'

" let airline use powerline fonts
  let g:airline_symbols = {}
  let g:airline_left_sep = '⮀'
  let g:airline_left_alt_sep = '⮁'
  let g:airline_right_sep = '⮂'
  let g:airline_right_alt_sep = '⮃'
  let g:airline_symbols.branch = '⭠'
  let g:airline_symbols.readonly = '⭤'
  let g:airline_symbols.linenr = '⭡'

let g:airline_powerline_fonts = 1

" turn off current branch display
let g:airline_section_b = ''

" turn off file encoding display
let g:airline_section_y = ''

" enable airline's custom tabline
" let g:airline#extensions#tabline#enabled = 1
" https://powerline.readthedocs.org/en/latest/tipstricks.html#vim
" disabling this as it breaks ragtag functionality
" if ! has('gui_running')
"     set ttimeoutlen=10
"     augroup FastEscape
"         autocmd!
"         au InsertEnter * set timeoutlen=0
"         au InsertLeave * set timeoutlen=1000
"     augroup END
" endif

" suppress the '-- INSERT --' line
set noshowmode 

let g:syntastic_mode_map = { 'mode': 'passive', 'passive_filetypes': ['haml'], 'active_filetypes': ['html', 'js'] }

let delimitMate_expand_cr = 1
" PowerlineReloadColorscheme

" use 'the silver searcher' ag instead of ack for ack.vim
let g:ackprg = 'ag --nogroup --nocolor --column'

" color tir_black
" set light or dark colorscheme based on time of day
" let g:hour_of_day = strftime("%H")
" if g:hour_of_day > 18 || g:hour_of_day < 12
"   Dark
" else
"   Light
" endif

let s:ruby_deindent_keywords =
      \ '^\s*\zs\<\%(ensure\|else\|rescue\|elsif\|when\|public\|private\|protected\|end\):\@!\>'


let g:sneak#streak = 1
" nmap f <Plug>SneakForward
" nmap F <Plug>SneakBackward
" xmap f <Plug>VSneakForward
" xmap F <Plug>VSneakBackward

let g:vim_json_syntax_conceal = 0

" color scheme
let g:airline_theme = 'base16' " 'tomorrow'
