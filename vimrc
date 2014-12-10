set runtimepath+=~/.vim/after
" ================================================================================
" PLUGIN BUNDLES
" ================================================================================
" pathogen config

if has('unix')
else
  " youcompleteme doesn't support windows
  let g:pathogen_disabled = ["YouCompleteMe"]
endif

call pathogen#infect()

" ================================================================================
" GENERAL 
" ================================================================================
set nocompatible
set ruler " note that this has no real affect if airline is on
set number
set nomodeline " don't look for vim modelines in files
set laststatus=2  " always show status bar (0=never, 1=default, 2=always)

if has("unix")
  set backupdir=/tmp
  set directory=/tmp
else
  set backupdir=C:\windows\temp
  set directory=c:\windows\temp
end

syntax on  " enable syntax coloring
filetype plugin indent on " load the plugin and indent settings for the detected filetype

" ================================================================================
" BELLS
" ================================================================================
set noerrorbells
set visualbell
set t_vb=
set novb

" ================================================================================
" WHITESPACE 
" ================================================================================
set nowrap
set nolist " turn off invisibles

if has('unix')
  set listchars=tab:▸\ ,eol:¬
else
  set listchars=tab:.\ ,eol:$
end


" ================================================================================
" LEADER 
" ================================================================================
let mapleader=","

" ================================================================================
" INPUT 
" ================================================================================
set mouse=a  " enable mouse in terminal
set cursorline " enable current line highlighting
set backspace=indent,eol,start  " allow backspacing over everything in insert mode 
set formatoptions+=j " remove comment character when joining lines
set iskeyword+=- " include - as part of keywords, for better css-class-name tab-completion

if has("unix")
  " change cursor 
  " where N=0, 1, or 2.
  " 0: Block
  " 1: Vertical bar
  " 2: Underline
  " t_SI is for insert mode
  " t_EI is for normal mode
  let &t_SI = "\<Esc>]50;CursorShape=2\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
end

" ================================================================================
" WINDOWS/BUFFERS/SPLITS 
" ================================================================================
" new splits should appear below/right of current window
set splitbelow
set splitright

" ================================================================================
" SEARCHING 
" ================================================================================
set hlsearch " highlight search results
set incsearch " highlight and jump to first result while typing
set ignorecase
set smartcase

" ================================================================================
" COMPLETION
" ================================================================================
set wildmode=list:longest,list:full
set wildignore=*.o,*.obj,.git,*.rbc,vendor/**,tmp/**,notes/**,templates/compiled/*
set complete-=i

" ================================================================================
" FOLDING 
" ================================================================================
set foldmethod=indent   "fold based on indent
set foldnestmax=10      "deepest fold is 10 levels
set nofoldenable        "dont fold by default
set foldlevel=1         "this is just what i use
set hidden " enable hidden buffer


" ================================================================================
" INDENTATION 
" ================================================================================
set smartindent
set autoindent
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set indentkeys="0{,0},0),0],!^F,o,O,e"

" when wrap is enabled, break at word boundaries
set linebreak 

" ================================================================================
" MISC
" ================================================================================
" set lines of context when scrolling
set scrolloff=5

" large preview window
set previewheight=24

" Expands %% to the path of the current file
" http://vim.wikia.com/wiki/Easy_edit_of_files_in_the_same_directory
cabbr %% <C-R>=expand('%:p:h')<CR>

" include the matchit support for the vim-textobj-* plugins
runtime! macros/matchit.vim

let g:notes_directory = '~/.vim/notes'

" ================================================================================
" PLUGIN BUNDLES 
" ================================================================================
" pathogen config
" call pathogen#infect()

" ================================================================================
" COLOR 
" ================================================================================
if exists("+guicolors")
  set guicolors " supposed to allow 24-bit colors but not working yet
  set t_8f=[38;2;%lu;%lu;%lum
  set t_8b=[48;2;%lu;%lu;%lum
  color dracula
  set background=dark

else
  set background=dark

  if has("unix")
    color base16-default
  else
    color default
  end
end

" when colorcolumn is set, use a gray color for highlighting
highlight ColorColumn ctermbg=240

" ================================================================================
" Shell configuration
" ================================================================================
if has('unix')
  set shell=/bin/zsh\ -l
else
  set shell=powershell
  set shellcmdflag=-command
end
