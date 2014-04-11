" sticky-shift (http://www.linuxforums.org/forum/applications/171681-bind-capital-w-write-vim.html)
command! WQ wq
command! Wq wq
command! W w
command! Q q
command! Qa qa
command! Vimrc  tabe ~/.vimrc
command! Httpd  tabe ~/httpd.conf
command! FixCR  :%s/

command! -nargs=+ Gcm Gcommit -a -m 

" add Pull and Push commands to invoke git
command! Pull Git pull
command! Push Git push
command! Gpull Git pull
command! Gpush Git push