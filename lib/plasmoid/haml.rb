require 'haml'

module Plasmoid
  class Haml
    def initialize(path)
      @path = path
      @output_path = path.sub(/\.haml$/, "")

      Haml::Engine.new(File.read(@path)).def_method(self, :render)
    end

    def write
      File.open(@output_path, "w") do |f|
        f.write(self.render)
      end
    end

    def self.generate
      Dir["contents/**/**/*.haml"].each do |path|
        Plasmoid::Haml.new(path).write
      end
    end
  end
end
