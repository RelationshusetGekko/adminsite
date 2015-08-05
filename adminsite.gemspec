$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "adminsite/version"

Gem::Specification.new do |s|
  s.name = "adminsite"
  s.version =  Adminsite::VERSION
  s.authors = ["Robin Wunderlin"]
  s.email = "row@crd.dk"
  s.homepage = "http://www.crd.dk"
  s.summary = "Adminsite"
  s.description = "Adminsite plugin"

  s.files = Dir["[A-Z]*", "{app,config,db,public,lib,generators}/**/*"]+ ["MIT-LICENSE", "Rakefile", "README.markdown"]
  s.extra_rdoc_files = [
    "README.markdown"
  ]

  s.required_ruby_version = '>= 2.1.2'
  s.require_paths = ["lib"]

  s.date = "#{Time.now.to_date}"
  s.post_install_message = File.open('USAGE').read

  s.add_runtime_dependency(%q<rails>, ["~> 4.2"])
  s.add_runtime_dependency(%q<actionpack-page_caching>, [">= 0"])
  s.add_runtime_dependency(%q<jquery-rails>, [">= 0"])
  s.add_runtime_dependency(%q<devise>, ["~> 3.4"])
  s.add_runtime_dependency(%q<haml>, [">= 0"])
  s.add_runtime_dependency(%q<sass-rails>, [">= 0"])
  s.add_runtime_dependency(%q<cocaine>, [">= 0"])
  s.add_runtime_dependency(%q<liquid>, [">= 0"])
  s.add_runtime_dependency(%q<paperclip>, [">= 0"])
  s.add_runtime_dependency(%q<fog>, [">= 0"])

end

