# encoding: utf-8

require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end

require 'rake'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  gem.name = "adminsite"
  # gem.executables = "jeweler"
  gem.summary = "Adminsite"
  gem.email = "row@crd.dk"
  gem.homepage = "http://www.crd.dk"
  gem.description = "Adminsite plugin"
  gem.authors = ["Robin Wunderlin"]
  gem.files =  FileList["[A-Z]*", "{app,config,db,public,lib,generators}/**/*", 'lib/jeweler/templates/.gitignore']
  gem.post_install_message = <<-POST_INSTALL_MESSAGE
#{'*'*60}

  Thank you for installing Circle Adminsite

  Once you have installed this gem
  include it into your app Gemfile with:
  gem 'adminsite'

  Then from your app root type:
  rails generate adminsite

  For Mosso Cloud Files integration and Protected pages
  please refer to the README file in this gem root folder

  Export generator is also available:
  rails generate adminsite_exporter Product

#{'*'*60}
POST_INSTALL_MESSAGE
end

desc 'Copy gem file on gems.crd.dk'
task :publish do
  version = File.read('VERSION').strip
  puts "Publishing version #{version} on gems.crd.dk"
  system "scp pkg/adminsite-#{version}.gem gems.crd.dk:/usr/local/www/rubygems/gems/."
end

require 'rake/testtask'
desc 'Test the adminsite plugin.'
Rake::TestTask.new(:test) do |t|
  t.libs << 'lib'
  t.libs << 'test'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = true
end

require 'rcov/rcovtask'
Rcov::RcovTask.new do |test|
  test.libs << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
  test.rcov_opts << '--exclude "gems/*"'
end

desc 'Default: run unit tests.'
task :default => :test

require 'rdoc/task'
desc 'Generate documentation for the adminsite plugin.'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "test-gem #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

