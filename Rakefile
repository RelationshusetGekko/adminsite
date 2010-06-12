require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'

desc 'Default: run unit tests.'
task :default => :test

desc 'Test the adminsite plugin.'
Rake::TestTask.new(:test) do |t|
  t.libs << 'lib'
  t.libs << 'test'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = true
end

desc 'Generate documentation for the adminsite plugin.'
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'Adminsite'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

begin
  require 'jeweler'
  Jeweler::Tasks.new do |s|
    s.name = "adminsite"
    # s.executables = "jeweler"
    s.summary = "Adminsite"
    s.email = "lic@crd.dk"
    s.homepage = "http://www.crd.dk"
    s.description = "Adminsite plugin"
    s.authors = ["Liborio Cannici"]
    s.files =  FileList["[A-Z]*", "{app,config,db,public,lib,generators}/**/*", 'lib/jeweler/templates/.gitignore']
    # s.add_dependency 'schacon-git'
    s.add_dependency 'authlogic'
    s.add_dependency 'haml'
    s.add_dependency 'liquid'
    s.add_dependency 'paperclip-cloudfiles'
  end
rescue LoadError
  puts "Jeweler, or one of its dependencies, is not available. Install it with: sudo gem install technicalpickles-jeweler -s http://gems.github.com"
end