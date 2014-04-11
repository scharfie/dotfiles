let g:promptline_theme   = 'airline'
let g:promptline_symbols = {
    \ 'left'       : '⮀',
    \ 'left_alt'   : '⮁',
    \ 'right'      : '⮂',
    \ 'right_alt'  : '⮃',
    \ 'dir_sep'    : '/',
    \ 'truncation' : '⋯',
    \ 'vcs_branch' : '⭠ ',
    \ 'space'      : ' ' }

let g:promptline_preset = {
        \'a' : [ '★', promptline#slices#battery({'threshold': 25}) ],
        \'b' : [  ],
        \'c' : [ promptline#slices#cwd({'dir_limit': 2})  ],
        \'x' : [ promptline#slices#jobs() ],
        \'y' : [ promptline#slices#vcs_branch() ],
        \'warn' : [ promptline#slices#last_exit_code() ],
        \'options': {
          \'left_sections': ['a', 'c', 'y'],
          \'right_sections': ['x'] } }
