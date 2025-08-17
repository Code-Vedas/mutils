# frozen_string_literal: true

require 'coveralls'
require 'simplecov'
require 'simplecov-lcov'

SimpleCov::Formatter::LcovFormatter.config do |c|
  c.report_with_single_file = true
  c.output_directory = 'coverage'
  c.lcov_file_name = 'lcov.info'
  c.single_report_path = 'coverage/lcov.info'
end

SimpleCov.formatters = [SimpleCov::Formatter::HTMLFormatter, SimpleCov::Formatter::LcovFormatter]
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
