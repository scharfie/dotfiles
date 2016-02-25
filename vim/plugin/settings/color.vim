" ================================================================================
" COLOR 
" ================================================================================

set background=dark
hi clear

if exists("syntax_on")
  syntax reset
endif

if exists("+guicolors")
  set guicolors " supposed to allow 24-bit colors but not working yet
  set t_8f=[38;2;%lu;%lu;%lum
  set t_8b=[48;2;%lu;%lu;%lum
  color dracula

else
  if has("unix")
    if has("gui")
      color base16-chalk
    else
      " color base16-default
      color jellybeans
    end
  else
    color default
  end
end

" when colorcolumn is set, use a gray color for highlighting
" highlight ColorColumn ctermbg=240
" highlight LineNr ctermbg=0 ctermfg=11
" highlight Search ctermbg=15 ctermfg=0
