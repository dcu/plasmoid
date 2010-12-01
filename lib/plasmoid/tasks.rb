require 'rubygems'
require 'plasmoid/haml'
require 'plasmoid/package'

task :_init do
  File.open("metadata.desktop") do |f|
    f.each_line do |line|
      if line =~ /X-KDE-PluginInfo-Name=(.+)$/
        @filename = $1
        break
      end
    end

    if !@filename
      raise "X-KDE-PluginInfo-Name was not found in metadata.desktop"
    end
  end
end

desc "Compile haml files"
task :haml => [:_init] do
  Plasmoid::Haml.generate
end

desc "Generate plasmoid package"
task :pkg => [:_init, :haml] do
  Plasmoid::Package.new("#{@filename}.zip").write
end

desc "Installs the plasmoid"
task :install => [:_init, :pkg] do
  Plasmoid::Package.new("#{@filename}.zip").install
end

desc "View plasmoid"
task :view => [:_init, :install] do
  Plasmoid::Package.new("#{@filename}.zip").run
end

desc "Uninstalls the plasmoid"
task :uninstall => [:_init, :pkg] do
  Plasmoid::Package.new("#{@filename}.zip").uninstall
end

