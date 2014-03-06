# Colorized SVN status
command = "svn status #{ARGV.join(' ')}"

begin
  require 'term/ansicolor'
  include Term::ANSIColor
rescue Exception => e
  system command
  exit
end  

IO.popen(command) do |io|
  io.each_line do |line|
    print case line
    when /^M/  then line.blue.bold
    when /^\?/ then line.yellow.bold
    when /^D/  then line.red
    when /^X/  then next
    when /^A/  then line.green
    else line
    end
  end
end


