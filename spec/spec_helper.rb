# frozen_string_literal: true
require 'coveralls'
require 'simplecov'
SimpleCov.formatters = [SimpleCov::Formatter::HTMLFormatter, Coveralls::SimpleCov::Formatter]
SimpleCov.start do
  add_filter '/generators/'
  add_filter '/spec/'
  add_group 'Lib', '/lib/'
  add_group 'Lib:Method', '/methods/'
  add_group 'Lib:Results', '/results/'
end

require 'bundler/setup'
require_relative '../lib/mutils'

require 'benchmark'
require 'rspec-benchmark'

RSpec.configure do |config|
  config.include RSpec::Benchmark::Matchers
  config.example_status_persistence_file_path = '.rspec_status'
  config.disable_monkey_patching!
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
