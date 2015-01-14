" https://github.com/xolox/vim-easytags
" Note: vim-easytags plugin requires the 'vim-misc' plugin

" 0 -> don't auto update easytags when typing stops 
let g:easytags_on_cursorhold = 1

" asynchronous tag updating
let g:easytags_async = 1

" do not highlight tags (way too laggy)
let g:easytags_auto_highlight = 0

" use project-specific tag files
" When g:easytags_dynamic_files is set to 1 the easytags plug-in will write to
" the first existing tags file seen by Vim (based on the 'tags' option). In
" other words: If a project specific tags file is found it will be used,
" otherwise the plug-in falls back to the global tags file (or a file type
" specific tags file).
"
" If you set g:easytags_dynamic_files to 2 the easytags plug-in will
" automatically create project specific tags based on the first name in the
" 'tags' option. In this mode the the global tags file or file type specific
" tags files are only used for directories where you don't have write
" permissions.
let g:easytags_dynamic_files = 2

" let g:easytags_updatetime_min = 30000 " 30 seconds
