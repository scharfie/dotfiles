#!/usr/bin/env ruby

require "net/http"
require "uri"

username = 'scharfie'
password = 'Vcq4CwPUvi6FZfH8E72X'
url      = "https://nic.changeip.com/nic/update?set=1"

system %[curl -u "#{username}:#{password}" "#{url}"]
