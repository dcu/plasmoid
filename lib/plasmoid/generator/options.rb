require 'optparse'

module Plasmoid
  class Generator
    class Options < Hash
      attr_reader :parser, :argv

      def initialize(args)
        super()

        @argv = args.clone
        @parser = OptionParser.new do |o|
          o.banner = "Usage: #{File.basename($0)} [options] name\ne.g. #{File.basename($0)} weba"

          o.on('--directory [DIRECTORY]', 'specify the directory to generate into') do |directory|
            self[:directory] = directory
          end

          o.separator ""

          o.on('--haml', 'enable haml') do |o|
            self[:use_haml] = true
          end

          o.on('--jquery', 'enable jquery') do |o|
            self[:use_jquery] = true
          end

          o.on('--jquery-mobile', 'enable jquery mobile') do |o|
            self[:use_jquery] = true
            self[:use_jquery_mobile] = true
          end

          o.on('--jquery-ui', 'enable jquery ui') do |o|
            self[:use_jquery_ui] = true
          end

          o.separator ""

          o.on('--summary [SUMMARY]', 'specify the summary of the project') do |summary|
            self[:summary] = summary
          end

          o.on('--description [DESCRIPTION]', 'specify a description of the project') do |description|
            self[:description] = description
          end

          o.separator ""

          o.on('--user-name [USER_NAME]', "the user's name, ie that is credited in the LICENSE") do |user_name|
            self[:user_name] = user_name
          end

          o.on('--user-email [USER_EMAIL]', "the user's email, ie that is credited in the Gem specification") do |user_email|
            self[:user_email] = user_email
          end

          o.separator ""

          o.on('--homepage [HOMEPAGE]', "the homepage for your project") do |homepage|
            self[:homepage] = homepage
          end

          o.separator ""

          o.on_tail('-h', '--help', 'display this help and exit') do
            self[:show_help] = true
          end
        end

        begin
          @parser.parse!(args)
          self[:project_name] = args.shift
        rescue OptionParser::InvalidOption => e
          self[:invalid_argument] = e.message
        end
      end
    end
  end
end
