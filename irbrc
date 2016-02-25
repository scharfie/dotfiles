#!/usr/bin/ruby
require 'irb/completion'
require 'irb/ext/save-history'
require 'rubygems'
# require 'wirble'
require 'yaml'

# Wirble.init
# Wirble.colorize
# 
#
# NOTE:  had to run this on osx to get persistent history working:
# RUBY_CONFIGURE_OPTS=--with-readline-dir="$(brew --prefix readline)" rbenv install VERSION_HERE

IRB.conf[:SAVE_HISTORY] = 1000
IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/.irb_history"
IRB.conf[:PROMPT_MODE] = :SIMPLE
IRB.conf[:AUTO_INDENT] = true

class String
  def colorize(color_code); "\e[#{color_code}m#{self}\e[0m"; end
  def red; colorize(31); end
  def green; colorize(32); end
  def yellow; colorize(33); end
  def pink; colorize(35); end
end

class Object
  # list methods which aren't in superclass
  def local_methods(obj = self)
    (obj.methods - obj.class.superclass.instance_methods).sort
  end
  
  # print documentation
  #
  #   ri 'Array#pop'
  #   Array.ri
  #   Array.ri :pop
  #   arr.ri :pop
  def ri(method = nil)
    unless method && method =~ /^[A-Z]/ # if class isn't specified
      klass = self.kind_of?(Class) ? name : self.class.name
      method = [klass, method].compact.join('#')
    end
    puts `ri '#{method}'`
  end

  def x
    exit
  end

  def r!
    reload!
  end

  def rr
    reload!
  end
end

module Kernel
  def recognize_path(path)
    Rails.application.routes.recognize_path(path)
  end

  def x
    exit
  end

  def debug_i18n!
    def I18n.translate(key, *args)
      puts key.to_s.colorize(32)
      puts args.inspect.colorize(1)
      super
    end
  end
end

load File.dirname(__FILE__) + '/.railsrc' if $0 == 'irb' && ENV['RAILS_ENV']
load '.console' if File.exist?('.console')
