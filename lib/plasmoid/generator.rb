require 'git'
require 'erb'

require 'fileutils'
require 'pathname'
require 'find'

require 'plasmoid/generator/options'
require 'plasmoid/generator/template_helper'

module Plasmoid
  class Generator
    include TemplateHelper

    attr_accessor :target_dir
    attr_accessor :options
    attr_accessor :project_name, :summary, :description, :user_name, :user_email, :homepage

    def initialize(options = {})
      self.options = options

      self.project_name   = options[:project_name]
      if self.project_name.nil? || self.project_name.squeeze.strip == ""
        raise "no name was given"
      end

      self.target_dir             = options[:directory] || self.project_name

      self.summary                = options[:summary] || 'TODO: one-line summary of your plasmoid'
      self.description            = options[:description] || 'TODO: longer description of your plasmoid'

      self.user_name       = options[:user_name]
      self.user_email      = options[:user_email]
      self.homepage        = options[:homepage]
    end

    def self.run!(*args)
      options = self::Options.new(args)

      if options[:invalid_argument]
        $stderr.puts options[:invalid_argument]
        options[:show_help] = true
      end

      if options[:show_help]
        $stderr.puts options.parser
        return 1
      end

      if options[:project_name].nil? || options[:project_name].squeeze.strip == ""
        $stderr.puts options.parser
        return 1
      end

      generator = options[:generator].new(options)
      generator.run
      return 0
    end

    def run
      create_files
      create_version_control
      $stdout.puts "Your plasmoid is ready at #{target_dir}\ntype `rake -T` to see the available actions"
    end

    def create_version_control
      Dir.chdir(target_dir) do
        begin
          @repo = Git.init()
        rescue Git::GitExecuteError => e
          raise "Encountered an error during gitification. Maybe the repo already exists, or has already been pushed to?"
        end

        begin
          @repo.add('.')
        rescue Git::GitExecuteError => e
          raise
        end

        begin
          @repo.commit "Initial commit to #{project_name}."
        rescue Git::GitExecuteError => e
        end
      end
    end
  end
end
