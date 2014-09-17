require 'socket'

module PC
  MAC_ADDRESS = '10:C3:7B:6E:8A:A4'

  class Service
    def whitelist
      %w(sleep echo crash)
    end

    def valid_envelope?(envelope)
      return false unless envelope.respond_to?(:message)
      return false unless envelope.message.is_a?(Hash)
      return false unless envelope.message.has_key?('command')
      return false unless envelope.message.has_key?('arguments')
      return true
    end

    def crash
      1 / 0
    end

    def invoke(envelope)
      puts "* Bad request!" and return unless valid_envelope?(envelope)

      message = envelope.message
      command = message['command']
      args    = message['arguments']

      puts "* SERVER: invoke #{command} #{args.inspect}"

      if whitelist.include?(command)
        send command, *args
      else
        puts "* Unknown command #{command}"
      end
      return command
    rescue
      puts "* ERROR: #{$!}"
    end

    def sleep(*args)
      path = File.expand_path(File.dirname(__FILE__))
      command = "#{path}/wizmo.exe"
      exec(command, 'standby')
      puts command
    end

    def wake(*args)
      begin
        addr = ['<broadcast>', 9]

        socket = UDPSocket.new
        socket.setsockopt(Socket::SOL_SOCKET, Socket::SO_BROADCAST, true)

        data = "\xFF\xFF\xFF\xFF\xFF\xFF"
        mac = PC::MAC_ADDRESS
        arr = mac.split(':')

        16.times do |i|
          data<< arr[0].hex.chr+arr[1].hex.chr+arr[2].hex.chr+arr[3].hex.chr+arr[4].hex.chr+arr[5].hex.chr
        end

        puts("Wake-On-Lan packet sent to MAC address " + mac)

        socket.send(data, 0, addr[0], addr[1])
      end
    end

    def echo(*args)
      result = "* SERVER: echo => #{args.inspect}"
      puts result
      return result
    end
  end
end
