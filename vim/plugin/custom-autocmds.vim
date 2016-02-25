augroup default
  au!
  " Thorfile, Rakefile and Gemfile are Ruby
  au BufRead,BufNewFile {Gemfile,Rakefile,Thorfile,config.ru,.console}    set ft=ruby
  au BufRead {*.conf}   set ft=apache
  au BufRead *.html.erb set ft=eruby " .html.javascript
  au BufRead *.html.erb set comments=""
  au BufRead *.php      set ft=php
  au BufRead *.ko       set ft=javascript.html
  au BufRead *.mustache set ft=html
  au BufRead *.tpl      set ft=html
  au BufRead *.scss     set ft=scss

  au BufWritePost *.vim source %

  au BufNewFile,BufReadPost *.jd set ft=jade
  au BufRead,BufNewFile *.es6  set ft=javascript

  au BufRead {*/views/*.php,*/wp-content/themes/*.php,*.thtml} set ft=php.html commentstring=<?php\ #\ %s\ ?>
  au BufRead *.json.erb set ft=json
  au FileType gitcommit setlocal colorcolumn=50
  au FileType apache set commentstring=#\ %s
  au FileType changelog set expandtab

  " execute Dispatch after saving a ruby test file
  au BufWritePost test/*_test.rb Dispatch

  " recreate sites.conf after modifying sites.conf.rb
  au BufWritePost {~/httpd/sites.conf.rb,vhost.conf} !restart_apache

  " restart apache after modifiying httpd.conf
  au BufWritePost *.conf,/etc/php.ini,/private/etc/php.ini !sudo /usr/sbin/apachectl -k restart

  " restart mysql after editing config
  au BufWritePost /private/etc/my.cnf !mysql.server reload

  " reload this vimrc config file after saving
  au BufWritePost ~/.vimrc source %
  au BufWritePost *.vim source %

  " crontabs should not use tempfiles
  autocmd filetype crontab setlocal nobackup nowritebackup
augroup end
