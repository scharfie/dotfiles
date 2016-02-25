" https://github.com/junegunn/fzf/wiki/Examples-(vim)

" \ 'source':  reverse(s:all_files()),
command! FZFMru call fzf#run({
  \ 'source':  s:all_files(),
  \ 'sink':    'edit',
  \ 'options': '-m -x +s',
  \ 'down':    '40%' })

function! s:all_files()
  return extend(
  \ filter(copy(v:oldfiles),
  \        "v:val !~ 'fugitive:\\|NERD_tree\\|^/tmp/\\|.git/'"),
  \ map(filter(range(1, bufnr('$')), 'buflisted(v:val)'), 'bufname(v:val)'))

  let here  = getcwd()
  let files = copy(v:oldfiles)
  call filter(files, "v:val !~ 'fugitive:\\|NERD_tree\\|^/tmp/\\|.git/'")
  " call map(files, "substitute(v:val,'" . here . "','', '')")
  " call filter(files, "v:val =~ '" . here . "'")
  " call extend(files, map(filter(range(1, bufnr('$')), 'buflisted(v:val)'), 'bufname(v:val)'))
  return files
endfunction

function! s:buflist()
  redir => ls
  silent ls
  redir END
  return split(ls, '\n')
endfunction

function! s:bufopen(e)
  execute 'buffer' matchstr(a:e, '^[ 0-9]*')
endfunction

command! FZFBuffers call fzf#run({
  \   'source':  reverse(<sid>buflist()),
  \   'sink':    function('<sid>bufopen'),
  \   'options': '+m',
  \   'down':    len(<sid>buflist()) + 2
  \ })

command! FZFColor call fzf#run({
  \   'source':
  \     map(split(globpath(&rtp, "colors/*.vim"), "\n"),
  \         "substitute(fnamemodify(v:val, ':t'), '\\..\\{-}$', '', '')"),
  \   'sink':    'colo',
  \   'options': '+m',
  \   'left':    30
  \ })

map <Leader>f :FZF<CR>
map <Leader>e :FZF %%<CR>  " look for files in the same directory as buffer
map <Leader>r :FZFMru<CR>
map <Leader>b :FZFBuffers<CR>
map <Leader>v :FZF ~/.vim<CR>
map <Leader>c :FZFColor<CR>

function! s:fzf_related() 
  let basename = split(expand('%:t:r'), "_test")[0]
  let options = {
        \ 'options': '-x -q ' . basename,
        \ 'sink':    'edit',
        \ 'down':    '40%' }

  call fzf#run(options)
endfunction


command! FZFRelated call s:fzf_related()

map <Leader>a :FZFRelated<CR>

" command! FZFRelated call fzf#run({
"   let basename = split(expand('%:t:r'), "_test")[0]
"   'options': '-q '
" look for 'similar' files (take base filename of current buffer as default
" search input)
" note that it also removes _test from the search input
" nnoremap <Leader>a :FZF split(expand('%:t:r'), "_test")[0]
"       \|
  " \ call ctrlp#init(0) \| :unlet g:ctrlp_default_input<CR>

