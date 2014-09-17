#!/usr/bin/env ruby
require 'drb/drb'

module PC
  IP_ADDRESS  = '10.0.0.22'
  MAC_ADDRESS = '10:C3:7B:6E:8A:A4'
  PORT        = '8787'

  class Server
    SERVER_URI = "druby://#{PC::IP_ADDRESS}:#{PC::PORT}"

    def self.create
      while true do
        begin
          puts "* Starting server..."
          dispatcher = PC::Dispatcher.new
          DRb.start_service(SERVER_URI, dispatcher)
          DRb.thread.join
        rescue Exception
          puts $!
        end
      end
    end
  end

  class Dispatcher
    def invoke(command, *args)
      load 'pc/service.rb'
      service = PC::Service.new
      service.invoke(command, *args)
    end
  end

  class Client
    def self.create
      new
    end

    def dispatcher
      @dispatcher ||= DRbObject.new_with_uri(PC::Server::SERVER_URI)
    end

    def invoke(command, *args)
      case command
      when 'wake'
        require 'socket'
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

      else
        dispatcher.invoke(command, *args)

      end
    end
  end
end


mode = ARGV.shift

case mode
when 'server'
  PC::Server.create

when 'client'
  command = ARGV.shift
  args    = ARGV.dup

  client = PC::Client.create
  puts "* CLIENT: " + client.invoke(command, *args).to_s
end
