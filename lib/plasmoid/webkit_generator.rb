module Plasmoid
  class WebkitGenerator < Generator
    def create_files
      puts "Creating files in #{target_dir}"
      FileUtils.mkpath(target_dir)

      Find.find(template_dir) do |path|
        dest = path.sub(template_dir, "")

        next if path =~ /^\.+$/ || dest.empty? || path =~ /~$/
        if File.directory?(path)
          mkdir(dest)
        else
          write_template(dest, dest)
        end
      end

      if options[:use_haml]
        Dir.chdir(target_dir) do
          Dir.glob(File.join("contents/**/**/*.html")) do |path|
            dest = path + ".haml"
            puts dest
            system("html2haml '#{path}' '#{dest}'")
            File.unlink path
          end
        end
      end
    end
  end
end
