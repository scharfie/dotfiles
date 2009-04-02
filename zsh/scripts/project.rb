#!/usr/bin/ruby
require 'yaml'
require 'optparse'
require 'ostruct'

PATH        = File.join(File.dirname(__FILE__), *%w(project.go.sh))
CONFIG_FILE = File.join(File.dirname(__FILE__), *%w(project.yml))

#################################################
# Cutlery                                       #
#################################################

# Project model
class Project
  attr_accessor :path
  attr_accessor :urls
  attr_accessor :shell
  attr_accessor :aliases
  
  def initialize(options={})
    options.each {|k,v| send(k.to_s + '=', v)}
  end
  
  def aliases
    (@aliases ||= '').split(',').map { |e| e.strip }
  end
  
  def alias?(key)
    aliases.include?(key)
  end
  
  def open(options)
    commands =  []
    commands += [*urls].compact.map { |e| %Q(open -g "#{e}") } if options.all
    commands << %Q(mate "#{path}") if options.all || options.edit
    commands << %Q(cd "#{path}") if options.all || options.chdir
    commands << shell if options.all
    puts commands and exit 0 # if options.debug
    # File.open(PATH, 'w') { |f| f.write(commands.join("\n")) }
  end
end

# Argument parser
class ProjectOptionParser
  def self.parse(args)
    options = OpenStruct.new
    options.all = false
    options.chdir = true
    
    parser = OptionParser.new do |e|
      e.banner = "Usage: project.rb <project[/path]> [options]"
      # e.on('-c', '--chdir', 'Change directory') do
      #   options.all   = false
      #   options.chdir = true
      # end

      e.on('-r', '--run', '"Run" the project') do
        options.all = true
        options.chdir = false
      end
      
      e.on('-e', '--edit', 'Open project in editor') do
        options.all  = false
        options.edit = true
      end
      
      e.on('-d', '--debug') do
        options.debug = true
      end
      
      e.on('-l', '--list') do
        options.list = true
      end
    end
    
    parser.parse!(args)
    options  
  end
end

#################################################
# Meat                                          #
#################################################

unless File.file?(CONFIG_FILE)
  puts "Please define your projects in #{CONFIG_FILE}"
  exit 1
end

# Load project config file
projects = YAML.load(File.read(CONFIG_FILE))
class << projects
  def [](key)
    value = super
    return value if value
    values.each { |p| return p if p.alias?(key) }
    nil
  end

  def keys
    super.inject(super) { |array, key| array << self[key].aliases }.flatten
  end
end

# Project is the first argument, parse the rest
choice  = (ARGV.shift || '').chomp
options = ProjectOptionParser.parse(ARGV)

# List projects (useful with bash tab completion)
if choice == '-l' || options.list
  puts projects.keys
  exit 1
end

# Grab project (exit if no matching project)
exit unless project = projects[choice]

# Open the project
project.open(options)