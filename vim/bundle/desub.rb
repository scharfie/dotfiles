require 'pathname'

Pathname.new(__FILE__).dirname.entries.each do |dir|
  next unless dir.directory?
  next if ['.', '..'].include?(dir.to_s)
  command =  "git rm -r --cached #{dir}; git add #{dir}/"
  puts %x[#{command}]
end
