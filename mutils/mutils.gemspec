# frozen_string_literal: true

version = File.read(File.expand_path('lib/mutils/version.rb', __dir__))
              .match(/VERSION\s*=\s*['"]([^'"]+)['"]/)[1]

Gem::Specification.new do |spec|
  spec.name = 'mutils'
  spec.version = version
  spec.authors = ['Nitesh Purohit', 'Codevedas Inc.']
  spec.email = ['nitesh.purohit.it@gmail.com', 'team@codevedas.com']

  spec.summary = 'General-purpose Ruby helpers for application development'
  spec.description = <<~DESC
    Mutils is a general-purpose Ruby helper gem for application development.
    It currently includes a lightweight serialization toolkit and is designed to grow with additional reusable helpers over time.
  DESC
  spec.homepage = 'https://github.com/Code-Vedas/mutils'
  spec.license = 'MIT'
  spec.metadata['bug_tracker_uri'] = 'https://github.com/Code-Vedas/mutils/issues'
  spec.metadata['changelog_uri'] = 'https://github.com/Code-Vedas/mutils/blob/main/CHANGELOG.md'
  spec.metadata['documentation_uri'] = 'https://mutils.codevedas.com'
  spec.metadata['homepage_uri'] = 'https://github.com/Code-Vedas/mutils'
  spec.metadata['source_code_uri'] = 'https://github.com/Code-Vedas/mutils.git'
  spec.metadata['funding_uri'] = 'https://github.com/sponsors/Code-Vedas'
  spec.metadata['support_uri'] = 'https://mutils.codevedas.com'
  spec.metadata['rubygems_uri'] = 'https://rubygems.org/gems/mutils'
  spec.metadata['rubygems_mfa_required'] = 'true'
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir['{bin,exe,lib}/**/*', 'LICENSE', 'Rakefile', 'README.md']
  end
  spec.require_paths = ['lib']
  spec.required_ruby_version = '>= 3.2'
  spec.add_dependency 'dry-inflector', '~> 1.3'
end
