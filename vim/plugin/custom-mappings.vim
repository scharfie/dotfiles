" hide search highlights by typing // in normal mode
noremap <silent> // :noh<CR>

" begin easy align from visual mode by pressing enter
vnoremap <silent> <Enter> :EasyAlign<Enter>

map <Leader>gw :w<CR>
map <Leader>w :w<CR>
map <Leader>q :q<CR>

map <Leader>z :Bonly<CR>:tabonly<CR>

" Opens a tab edit command with the path of the currently edited file filled in
" Normal mode: <Leader>te
map <Leader>te :tabe <C-R>=expand("%:p:h") . "/" <CR>

" Opens edit command with path of the currently edited file filled in
map <Leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

" F3 and F4 for prev/next tab in insert and normal mode
inoremap <F3> <ESC>:tabprev<CR>
noremap <F3> <ESC>:tabprev<CR>
inoremap <F4> <ESC>:tabnext<CR>
noremap <F4> <ESC>:tabnext<CR>

noremap <space> zz

" gp and gP select the last paste, in char-wise (p) or line-wise (P) mode
noremap gp `[v`]
noremap gP `[V`]

" triple = reindents file
noremap === :norm gg=G``zz<CR>
