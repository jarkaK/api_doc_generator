# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'api_doc_generator/version'

Gem::Specification.new do |spec|
  spec.name          = 'api_doc_generator'
  spec.version       = ApiDocGenerator::VERSION
  spec.authors       = ['Jaroslava Kadlecova']
  spec.email         = ['kadlecovaj@gmail.com']
  spec.description   = 'Generation of API documentation from specs'
  spec.summary       = 'Generation of API documentation from specs'
  spec.homepage      = 'https://github.com/jarkadlec/'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(spec)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.3'

  spec.add_dependency 'rspec', '~> 3.5.0'
  spec.add_dependency 'pry', '~> 0.10'
end
