# https://github.com/pry/pry/issues/492
begin
  Pry::Commands.delete 'c'
  Pry::Commands.delete 'n'
  Pry::Commands.delete 's'
rescue StandardError
end

def x
  exit
end

def handle!
  begin
    yield

  rescue Exception, StandardError
    puts "\nException: #{$!}"
    binding.pry
  end
end

Pry.config.exception_handler = proc do |output, exception, _pry_|
  output.puts "#{exception}"
  output.puts exception.backtrace.first(10).join("\n")
  _pry_.run_command 'cat --ex'
end
