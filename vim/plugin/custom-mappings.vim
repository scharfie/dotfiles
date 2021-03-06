nnoremap [[ :bprevious<CR>
nnoremap ]] :bnext<CR>

nnoremap <Tab> <c-w>w

" toggle paste
nnoremap <c-p> :set paste!<CR>

" hide search highlights by typing // in normal mode
noremap <silent> // :noh<CR>

" begin easy align from visual mode by pressing enter
vnoremap <silent> <Enter> :EasyAlign<Enter>

noremap <Leader>gw :w<CR>
noremap <Leader>w :w<CR>
noremap <Leader>q :q<CR>
noremap <Leader>gw :Gwrite<CR>

noremap <silent> <Leader>z :Bonly<CR>:tabonly<CR>

" toggle invisibles
noremap <Leader>l :set list!<CR>


" Opens edit command with path of the currently edited file filled in
noremap <Leader>e :CtrlP <C-R>=expand("%:p:h") . "/" <CR><CR>
" noremap <Leader>te :tabe <C-R>=expand("%:p:h") . "/" <CR>
" noremap <Leader>tn :tabnew<CR>

" F3 and F4 for prev/next tab in insert and normal mode
" inoremap <F3> <ESC>:tabprev<CR>
" noremap <F3> <ESC>:tabprev<CR>
" inoremap <F4> <ESC>:tabnext<CR>
" noremap <F4> <ESC>:tabnext<CR>

nnoremap <leader>d :Dispatch<CR>


noremap <space> zz

" gp and gP select the last paste, in char-wise (p) or line-wise (P) mode
noremap gp `[v`]
noremap gP `[V`]

" triple = reindents file
noremap === :norm gg=G``zz<CR>

" http://blog.sanctum.geek.nz/vim-annoyances/
" Skipping lines when wrap is set

" By default, the j and k keys don’t move by row; they move by line. This
" means that if you have the wrap option set, you might skip across several
" rows to reach the same point in an adjacent line.
"
" This can be frustrating if you prefer the more intuitive behavior of moving
" up to the character immediately above the current one. If you don’t like
" this behavior, you can fix it by mapping j to gj, and k to gk, which moves
" by rows rather than lines:
nnoremap j gj
nnoremap k gk

" If you think you might need the default behavior at some point, you might
" want to include reverse mappings so you can move linewise with gj and gk:
nnoremap gj j
nnoremap gk k

" change the highlight search match
nnoremap cv cgn

" Accidentally hitting unwanted keys in normal mode

" Some of the keys in normal mode bring up functions that aren’t terribly
" useful to a lot of people, and tend to accidentally get hit when Caps Lock
" is on, or when aiming for another key. Common nuisance keys are:

"     F1 for help; :help is generally more useful for the experienced user
"     Q to start ex mode; annoying when you intended to start recording a macro with q
"     K to bring up a man page for the word under the cursor; annoying when
"       you’re not writing in C or shell script, and there isn’t a sensible
"       choice of keywordprg for your chosen language

" The simplest way to deal with these is to remap them to <nop> so that they
" don’t do anything:
nnoremap <F1> <nop>
nnoremap Q <nop>

nmap <silent> K <Plug>DashSearch


" in normal model, scroll the screen left/right
" swap the default behavior because scrolling half-screen (zH, zL) is typically more
" useful than scrolling a single column (zh, zl)
nnoremap zh zH
nnoremap zl zL

nnoremap zH zh
nnoremap zL zl

" perform literal search for word at cursor
nnoremap ## :Ag -Q "<c-r>=expand("<cword>")<CR>"<CR>


" " yank the visual selection to the system 'C'lipboard
" vnoremap CY "+y

" " paste from the system 'C'lipboard, replacing visual selection
" vnoremap CP "+p

" " paste from system clipboard in insert mode
" inoremap PP "+P

" jumps to last edited file
" nnoremap ff :b#<CR>
" nnoremap fF :b#<CR>
" nnoremap Ff :b#<CR>
" nnoremap FF :b#<CR>
nnoremap ff :PreviousBuffer<CR>
nnoremap fF :PreviousBuffer<CR>
nnoremap Ff :PreviousBuffer<CR>
nnoremap FF :PreviousBuffer<CR>

map z/ <Plug>(incsearch-fuzzy-/)
map z? <Plug>(incsearch-fuzzy-?)
map zg/ <Plug>(incsearch-fuzzy-stay)

