# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'knife-aws/version'

Gem::Specification.new do |gem|
  gem.name          = "knife-aws"
  gem.version       = Knife::Aws::VERSION
  gem.authors       = ["Paul Gilligan"]
  gem.email         = ["paul.gilligan@mac.com"]
  gem.license       = 'Apache 2.0'
  gem.summary       = %q{Extends knife to manage aws applications}
  gem.description   = %q{A utility to manage aws applications end to end}
  gem.homepage      = "https://github.com/pauldavidgilligan/knife-aws"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})

  gem.add_dependency 'fog'
  gem.add_dependency 'rb-readline'

  gem.add_development_dependency 'bundler'
  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'chef'

  gem.require_paths = ["lib"]
end
