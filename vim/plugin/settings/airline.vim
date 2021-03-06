let g:airline_unicode = has('unix')
let g:airline_unicode = 0

if airline_unicode
  " let airline use powerline fonts
  let g:airline_symbols = {}
  let g:airline_left_sep = '⮀'
  let g:airline_left_alt_sep = '⮁'
  let g:airline_right_sep = '⮂'
  let g:airline_right_alt_sep = '⮃'
  let g:airline_symbols.branch = '⭠'
  let g:airline_symbols.readonly = '⭤'
  let g:airline_symbols.linenr = '⭡'
  let g:airline_powerline_fonts = 1
else
  " let airline use powerline fonts
  let g:airline_symbols = {}
  let g:airline_left_sep = ''
  let g:airline_left_alt_sep = ''
  let g:airline_right_sep = ''
  let g:airline_right_alt_sep = ''
  " let g:airline_symbols.branch = ''
  " let g:airline_symbols.readonly = ''
  " let g:airline_symbols.linenr = ''
  let g:airline_powerline_fonts = 0
end


" turn off current branch display
" let g:airline_section_b = ''

" turn off file encoding display
let g:airline_section_y = ''
let g:airline_section_y = '%b 0x%B'

" enable airline's custom tabline
" let g:airline#extensions#tabline#enabled = 1

" color scheme
let g:airline_theme = 'jellybeans' " 'tomorrow'

" if exists("+guicolors")
"   let g:airline_theme = 'kolor'
" endif
