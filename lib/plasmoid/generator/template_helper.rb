module Plasmoid
  class Generator
    module TemplateHelper
      def self.included(base)
        base.class_eval do
        end
      end

      def template_dir
        @template_dir ||= File.join(File.dirname(__FILE__), 'templates')
      end

      def render_template(source)
        template_contents = File.read(File.join(template_dir, source))
        template          = ERB.new(template_contents, nil, '<>')

        template.result(binding).gsub(/\n\n\n+/, "\n\n")
      end

      def write_template(source, destination = source)
        final_destination = File.join(target_dir, destination)
        template_result   = render_template(source)

        File.open(final_destination, 'w') do |file|
          file.write(template_result)
        end

        $stdout.puts ">> create\t#{final_destination}"
      end

      def mkdir(path)
        destination = File.join(target_dir, path)
        FileUtils.mkpath(destination)
        $stdout.puts ">> mkdir\t#{destination}"
      end

    end
  end
end
