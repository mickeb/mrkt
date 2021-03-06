lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mrkt/version'

Gem::Specification.new do |spec|
  spec.name          = 'mrkt'
  spec.version       = Mrkt::VERSION
  spec.authors       = ['KARASZI István', 'Jacques Lemieux']
  spec.email         = ['github@spam.raszi.hu', 'jalemieux@gmail.com']
  spec.summary       = 'Marketo REST API Facade'
  spec.description   = 'This gem helps you to use the Marketo REST API'
  spec.homepage      = 'https://github.com/raszi/mrkt'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($RS)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = %w[lib]

  spec.required_ruby_version = '~> 2.0'

  spec.add_dependency 'faraday', '> 0.9.0', '< 0.14.0'
  spec.add_dependency 'faraday_middleware', '> 0.9.0', '< 0.13.0'

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake', '~> 12.3'
  spec.add_development_dependency 'rspec', '~> 3.2'
  spec.add_development_dependency 'webmock', '~> 3.1'
  spec.add_development_dependency 'codeclimate-test-reporter', '~> 1.0'
  spec.add_development_dependency 'rubocop', '~> 0.50.0'
  # Ruby 2.0 compatibility
  spec.add_development_dependency 'pry-byebug', '>= 3.4', '< 3.5'
  spec.add_development_dependency 'public_suffix', '>= 2.0', '< 3.0'
end
