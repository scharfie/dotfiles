" sticky-shift (http://www.linuxforums.org/forum/applications/171681-bind-capital-w-write-vim.html)
command! WQ wq
command! Wq wq
command! Wqa wqa
command! W w
command! Q q
command! Qa qa
command! Vimrc  tabe ~/.vimrc
command! Httpd  tabe ~/httpd.conf
command! FixCR  :%s//\r/g

command! -nargs=+ Gcm Gcommit -a -m

" add Pull and Push commands to invoke git
command! Pull Git pull
command! Push Git push
command! Gpull Git pull
command! Gpush Git push

" get the syntax group at the cursor
command! SyntaxID echo synIDattr(synID(line("."),col("."),1),"name")


" within a migration, do :Rredo
" the R* naming convention is to be consistent with rails-vim commands
function! Rredo()
  let l:migration_version = matchstr(expand('%:p'), "\\d\\+")
  execute "!rake db:migrate:redo VERSION=" . l:migration_version . " --trace && rake db:test:prepare --trace"
endfunction
command! Rredo call Rredo()

command! TidyHTML :read! tidy -mi -xml -wrap 0 -quiet --show-errors 0 %

" fill the args list with results from ag
command! -nargs=+ Args execute 'silent args `ag -l <args>`'
