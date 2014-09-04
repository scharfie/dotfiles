module PC
  class Service
    def whitelist
      %w(sleep echo)
    end

    def invoke(command, *args)
      puts "* SERVER: invoke #{command} #{args.inspect}"

      if whitelist.include?(command)
        send command, *args
      end
      return command
    end

    def sleep(*args)
      path = File.expand_path(File.dirname(__FILE__))
      command = "#{path}/wizmo.exe"
      exec(command, 'standby')
      puts command
    end

    def echo(*args)
      message = args.first
      result = "* SERVER: #{message}"
      puts result
      return result
    end
  end
end
