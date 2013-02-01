#!/usr/bin/env ruby
require 'yaml'
base = "http://dl.dropbox.com/u/8084951/"
file = ARGV.shift

%x[cp "#{file}" ~/DropBox/Public/]

puts File.join(base, File.basename(file))