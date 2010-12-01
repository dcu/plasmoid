require 'find'
require 'zip/zipfilesystem'

module Plasmoid
  class Package
    def initialize(filename)
      @filename = filename
      @pkg_name = File.basename(@filename, ".zip")
    end

    def write
      File.unlink(@filename) if File.exist?(@filename)
      Zip::ZipFile.open(@filename, Zip::ZipFile::CREATE) do |zf|
        Find.find(".") do |path|
          path.sub!(/^\.\//, "")

          if path.empty? || path =~ /^\.+$/ || path =~ /\.(zip|haml)$/ || path == "Rakefile"
            next
          end

          if File.directory?(path)
            zf.dir.mkdir(path)
          else
            zf.file.open(path, "w") do |file|
              file.write(File.read(path))
            end
          end
        end
      end
    end

    def run
      system("plasmoidviewer '#{@pkg_name}'")
    end

    def install
      system("plasmapkg -i '#{@filename}'")
    end

    def uninstall
      system("plasmapkg -r '#{@pkg_name}'")
    end
  end
end
