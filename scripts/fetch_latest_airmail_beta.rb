#!/usr/bin/env ruby
require 'rubygems'
# require 'faraday'
require 'faraday_middleware'
require 'nokogiri'
require 'open-uri'

def run(command)
  puts "* #{command}"
  puts `#{command}`
end

def fetch_latest_beta_url
  url = "http://airmailapp.com/beta"

  connection = Faraday.new(url) do |b|
    b.use FaradayMiddleware::FollowRedirects
    b.adapter :net_http
  end

  data = connection.get.body

  doc = Nokogiri::HTML(data)

  button = doc.at_css('.app-body a.button:first')

  url = button.attributes['href']
end

def download_latest_beta(url)
  path = "/Applications/AirMail_Beta.zip"
  run %[curl -L -o #{path} "#{url}"]
  path
end

def unzip_latest_beta(path)
  run %[cd #{File.dirname(path)}; unzip -o #{File.basename(path)}]
end

def kill_airmail
  run %(pkill "Airmail Beta")
end

def start_airmail
  run %(open -a 'Airmail Beta')
end

kill_airmail
url = fetch_latest_beta_url
path = download_latest_beta(url)
unzip_latest_beta(path)
start_airmail
