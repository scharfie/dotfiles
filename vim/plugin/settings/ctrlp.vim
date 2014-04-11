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
