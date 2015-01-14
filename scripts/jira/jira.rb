#!/usr/bin/env ruby
require "rubygems" 
require "thor"
require 'pathname'
require 'yaml'

module Jira
  def self.configuration
    @configuration ||= Configuration.new
  end

  class Configuration
    attr_accessor :username, :password
    attr_accessor :server
    attr_accessor :rsync_source

    def initialize(attributes = {})
      read_configuration
      self.attributes = attributes
    end

    def read_configuration
      path = Pathname.new(ENV['HOME']).join('.jirarc')
      yaml = YAML.load(path.read) if path.exist?
      self.attributes = yaml
    end

    def attributes=(hash)
      hash.each do |key, value|
        instance_variable_set :"@#{key}", value
      end
    end

    def url(path)
      File.join("http://issues.igicom.com", path || '')
    end

    def jira_cli_command
      %[java -jar "#{jira_cli_jar_path}" --server "#{server}" --user "#{username}" --password "#{password}"]
    end

    def jira_cli_jar_path
      Pathname.new(__FILE__).dirname.join('jira-cli/lib/jira-cli-2.1.0.jar')
    end
  end

  # Jira project model
  class Project
    attr_accessor :name
    attr_accessor :project_id
    attr_accessor :description

    # returns new Project object
    # the format of the incoming line should be
    # NAME, ID, DESCRIPTION
    def self.parse(line)
      name, project_id, description = project_line.split(',', 3)
      return nil if project_id.nil?

      project = Project.new(name)
      project.project_id = project_id
      project.description = description
      project
    end

    def initialize(name)
      @name = name.upcase
    end

    alias_method :to_s, :name
  end

  # Jira ticket model
  class Ticket
    attr_accessor :name, :project, :number

    def self.prepare(ticket)
      return ticket if Ticket === ticket
      new(ticket)
    end

    def initialize(name)
      @name  = name.upcase
      @project, @number = @name.to_s.split('-', 2)
      @project = Project.new(@project)
    end

    def url
      Jira.configuration.url("/browse/#{name}")
    end
  end

  # Thor command-line interface
  class CLI < Thor
    include Thor::Actions

    namespace "jira"
    
    desc "download TICKET", "Download attachments for ticket"
    method_options :never => :boolean

    def download(ticket)
      ticket = Ticket.prepare(ticket)
      remote  = "#{Jira.configuration.rsync_source}/#{ticket.project}/#{ticket.name}/"
      run "mkdir -p notes/#{ticket.name}"
      run "rsync -avpP --exclude=_thumb_ #{remote} notes/#{ticket.name}"
      invoke :notes, [ticket]
    end

    desc "browse TICKET", "Browse the given ticket in JIRA"
    def browse(ticket)
      ticket = Ticket.prepare(ticket)
      open_url ticket.url
    end

    desc "show TICKET", "Show the given ticket in terminal"
    def show(ticket)
      run_jira_cli "getIssue", options.merge(:issue => ticket)
    end

    desc "estimate TICKET HOURS", "Set time estimate on ticket to given hours (0.5 for half-hour)"
    def estimate(ticket, hours)
      run_jira_cli "setFieldValue", options.merge(
        :issue  => ticket,
        :field  => "customfield_10021",
        :values => hours
      )
    end

    desc "resolve TICKET [RESOLUTION]", "Progress the ticket to Resolved with optional resolution (default 'Fixed')"
    method_options :comment => :string
    def resolve(ticket, resolution="Fixed")
      run_jira_cli "progressIssue", options.merge(
        :issue => ticket,
        :step  => 5,
        :resolution => resolution
      )
    end

    desc "qa TICKET [RESOLUTION]", "Submit the ticket for QA optional resolution (default 'Fixed')"
    method_options :comment => :string
    def qa(ticket, resolution="Fixed")
      run_jira_cli "progressIssue", options.merge(
        :issue => ticket,
        :step  => 791,
        :resolution => resolution
      )
    end

    desc "notes TICKET", "Open notes folder for given ticket"
    def notes(ticket)
      ticket = Ticket.prepare(ticket)
      run "open 'notes/#{ticket.name}'"
    end

    desc "projects", "Retrieve list of projects"
    def projects(unused)
      data = run_jira_cli("getProjectList", {}, :capture => true)
      projects = data.split.map { |line| Project.parse(line) }
    end

    # not working yet
    desc "taskboard PROJECT_ID", "Browse the task board in JIRA for the given PROJECT_ID"
    def taskboard(ticket)
      ticket = Ticket.prepare(ticket)
      y ticket

      # TODO - make this not hardcoded!!!
      open_url "http://issues.igicom.com/secure/TaskBoard.jspa?selectedProjectId=" + project.project_id
    end

  protected
    def run_jira_cli(command, options, run_options={})
      options ||= {}
      options[:action] = command
      run_options = {
        :verbose => false, :capture => false
      }.merge!(run_options || {})

      args = options.map { |key, value| %[--#{key} "#{value}"] }.join(' ')
      # say_status :run, "JIRA #{args}"
      run "#{Jira.configuration.jira_cli_command} #{args}", run_options
    end

    def open_url(url)
      run "open '#{url}'"
    end
  end
end

def ticket_from_branch
  `git branch` =~ /\* (\S+)\s/m
  $1
end

# inject jira ticket from current branch name if command
# doesn't already contain a ticket
args = ARGV.dup
action = args.shift
ticket = args.shift
ticket = ticket_from_branch unless ticket =~ /\w+-\d+/
args.unshift(ticket)
args.unshift(action)

Jira::CLI.start(args)
