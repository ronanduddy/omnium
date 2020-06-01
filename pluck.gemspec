# frozen_string_literal: true

require_relative 'lib/pluck/version'

Gem::Specification.new do |spec|
  spec.name = 'pluck'
  spec.version = Pluck::VERSION
  spec.platform = Gem::Platform::RUBY
  spec.summary = 'Pluck language.'
  spec.description = 'That is about the size of it'
  spec.homepage = 'https://github.com/ronanduddy/pluck'
  spec.license = 'MIT'
  spec.authors = ['Rónán Duddy']
  spec.email = ['ronanduddy@live.ie']

  spec.files = []
  spec.bindir = 'bin'
  spec.executables = ['pluck']
  spec.require_path = 'lib'

  spec.required_ruby_version = '>= 2.7.0'

  spec.add_development_dependency 'guard', '~> 2.16'
  spec.add_development_dependency 'guard-rspec', '~> 4.7', '>= 4.7.3'
  spec.add_development_dependency 'pry', '~> 0.12.2'
  spec.add_development_dependency 'pry-nav', '~> 0.3.0'
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'rspec', '~> 3.9'
  spec.add_development_dependency 'rubocop', '~> 0.81.0'
end
