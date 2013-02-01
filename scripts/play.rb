#!/usr/bin/env ruby
$VERBOSE = nil
require 'yaml'
require 'uri'
require 'rubygems'
require 'HighLine'

Song    = Struct.new(:url, :song_id, :song, :artist_id, :artist, :album_id, :album, :grooveshark_url)
h       = HighLine.new($stdin, $stdout)
q       = URI.encode(ARGV.join(' ').downcase.gsub(/[^a-z0-9 \']+/, ''))
url     = "http://tinysong.com/s/#{q}?limit=15"
results = %x{curl -s "#{url}"}.split("\n")
songs   = results.map { |line| Song.new(*line.split('; ')) }

h.choose do |menu|
  menu.index_suffix = ') '
  menu.hidden('quit') { exit }
  menu.hidden('exit') { exit }

  songs.each do |song|
    menu.choice h.color(song.song, :yellow) + ' - ' + h.color(song.artist, :green) + ' - ' + h.color(song.album, :blue) do
      system %Q{open -a Grooveshark -g "#{song.url}"}
    end
  end
end