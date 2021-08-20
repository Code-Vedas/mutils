# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mutils/version'

Gem::Specification.new do |spec|
  spec.name = 'mutils'
  spec.version = Mutils::VERSION
  spec.authors = ['Nitesh Purohit']
  spec.email = ['nitesh.purohit.it@gmail.com']

  spec.summary = 'mutils Utilities for rails app'
  spec.description = 'mutils Utilities for rails app'
  spec.homepage = 'https://github.com/code-vedas/mutils'
  spec.license = 'MIT'
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']
  spec.required_ruby_version = '>= 2.6.0'
  spec.required_rubygems_version = '>= 1.8.11'
  spec.add_dependency('dry-inflector')
  spec.add_development_dependency 'bundler', '~> 2.0'
  spec.add_development_dependency 'rake', '~> 13.0'

  spec.metadata = {
    'bug_tracker_uri' => 'https://github.com/code-vedas/mutils/issues',
    'source_code_uri' => "https://github.com/code-vedas/mutils/tree/v#{Mutils::VERSION}"
  }
end
