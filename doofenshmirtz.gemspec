# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'doofenshmirtz/version'

Gem::Specification.new do |spec|
  spec.name          = "doofenshmirtz"
  spec.version       = Doofenshmirtz::VERSION
  spec.authors       = ["John Bohn"]
  spec.email         = ["jjbohn@gmail.com"]
  spec.summary       = %q{Make your Rails code self destruct}
  spec.description   = %q{Set a date for your legacy code to explode, and it will!}
  spec.homepage      = "https://www.github.com/alphasights/doofenshmirtz"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "colorize", "~> 0.7"
  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
end
