# frozen_string_literal: true

require_relative 'lib/omnium/version'

Gem::Specification.new do |spec|
  spec.name = 'omnium'
  spec.version = Omnium::VERSION
  spec.platform = Gem::Platform::RUBY
  spec.summary = 'Omnium language.'
  spec.description = 'That is about the size of it'
  spec.homepage = 'https://github.com/ronanduddy/omnium'
  spec.license = 'MIT'
  spec.authors = ['Rónán Duddy']
  spec.email = ['dev@ronanduddy.xyz']
  spec.extra_rdoc_files = Dir['README.md', 'LICENSE.md']

  spec.files = Dir['lib/**/*']
  spec.require_paths = %w[lib]

  spec.bindir = 'exe'
  spec.executables = %w[omnium]

  spec.required_ruby_version = '>= 2.7.2'

  spec.add_development_dependency 'guard', '~> 2.16'
  spec.add_development_dependency 'guard-rspec', '~> 4.7', '>= 4.7.3'
  spec.add_development_dependency 'pry', '~> 0.12.2'
  spec.add_development_dependency 'pry-nav', '~> 0.3.0'
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'rspec', '~> 3.9'
  spec.add_development_dependency 'rubocop', '~> 0.81.0'
end
