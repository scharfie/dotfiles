" https://github.com/edkolev/promptline.vim
" w | source % | PromptlineSnapshot! ~/.shell_prompt.sh airline 
" let g:promptline_theme   = 'airline'
let g:promptline_theme   = 'jelly'
let g:promptline_symbols = {
    \ 'left'       : '⮀',
    \ 'left_alt'   : '⮁',
    \ 'right'      : '⮂',
    \ 'right_alt'  : '⮃',
    \ 'dir_sep'    : '/',
    \ 'truncation' : '⋯',
    \ 'vcs_branch' : '⭠ ',
    \ 'space'      : ' ' }

let g:promptline_powerline_symbols = 0

" ★
let g:promptline_preset = {
        \'a' : [ promptline#slices#cwd({'dir_limit': 2}), promptline#slices#battery({'threshold': 25}) ],
        \'b' : [  ],
        \'c' : [  ], 
        \'x' : [ promptline#slices#jobs() ],
        \'y' : [ promptline#slices#vcs_branch() ],
        \'warn' : [ promptline#slices#last_exit_code() ],
        \'options': {
          \'left_sections': ['a', 'c', 'y'],
          \'right_sections': ['x'] } }
