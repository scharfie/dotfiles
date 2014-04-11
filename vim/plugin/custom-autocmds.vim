" Thorfile, Rakefile and Gemfile are Ruby
au BufRead,BufNewFile {Gemfile,Rakefile,Thorfile,config.ru}    set ft=ruby
au BufRead {*.conf}   set ft=apache
au BufRead *.html.erb set ft=eruby.html.javascript
au BufRead *.html.erb set comments=""
au BufRead *.php      set ft=php
au BufRead *.ko       set ft=javascript.html
au BufRead *.mustache set ft=html
au BufRead *.tpl      set ft=html
au BufRead *.scss     set ft=scss
au BufRead app/views/*.php set ft=phtml
au BufRead *.thtml set ft=phtml
au BufRead *.json.erb set ft=json
au FileType gitcommit setlocal colorcolumn=50
au FileType apache set commentstring=#\ %s
au FileType changelog set expandtab

" recreate sites.conf after modifying sites.conf.rb
au BufWritePost ~/httpd/sites.conf.rb !ruby ~/httpd/sites.conf.rb

" restart apache after modifiying httpd.conf
au BufWritePost *.conf,/etc/php.ini,/private/etc/php.ini !sudo /usr/sbin/apachectl -k restart

" restart mysql after editing config
au BufWritePost /private/etc/my.cnf !mysql.server reload

" reload this vimrc config file after saving
au BufWritePost ~/.vimrc source %


