" fix simple spelling mistakes
abbreviate teh the
abbreviate optoins options
abbreviate edn end

" Expands %% to the path of the current file
" http://vim.wikia.com/wiki/Easy_edit_of_files_in_the_same_directory
cabbr %% <C-R>=expand('%:p:h')<CR>

" expands cword in the command line to the word at the cursor
cabbr cword <C-R>=expand('<cword>')<CR>

