" eruby should fallback to using custom Html indent
" instead of using cindent.  This should hopefully provide
" better indenting of javascript in script tags of eruby
" templates
" let &l:indentexpr = 'HtmlIndentGetter(v:lnum)'

let g:ruby_indent_access_modifier_style = 'outdent'

let s:ruby_deindent_keywords =
      \ '^\s*\zs\<\%(ensure\|else\|rescue\|elsif\|when\|public\|private\|protected\|end\):\@!\>'
