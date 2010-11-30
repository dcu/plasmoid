require 'rubygems'
require 'plasmoid/haml'
require 'plasmoid/package'

desc "Compile haml files"
task :haml do
  Plasmoid::Haml.generate
end

desc "Generate plasmoid package"
task :pkg => [:haml] do
  Plasmoid::Package.new("shapado.zip").write
end

desc "Installs the plasmoid"
task :install => [:pkg] do
  Plasmoid::Package.new("shapado.zip").install
end

desc "View plasmoid"
task :view => [:install] do
  Plasmoid::Package.new("shapado.zip").run
end

desc "Uninstalls the plasmoid"
task :uninstall => [:pkg] do
  Plasmoid::Package.new("shapado.zip").uninstall
end

