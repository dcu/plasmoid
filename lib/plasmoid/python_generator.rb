module Plasmoid
  class PythonGenerator < Generator
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
    end
  end
end
