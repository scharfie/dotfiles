let g:syntastic_filetype_map = { 'html.handlebars': 'handlebars' }
let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['haml'], 'active_filetypes': ['ruby', 'html', 'js'] }
let g:syntastic_javascript_jslint_args = "--white --var --predef $ --predef window"

let g:syntastic_javascript_checkers = ['jshint']
let g:syntastic_javascript_jsxhint_exec = 'jshint'

" let g:syntastic_javascript_checkers = ['jsxhint']
" let g:syntastic_javascript_jsxhint_exec = 'jsx-jshint-wrapper'

" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
