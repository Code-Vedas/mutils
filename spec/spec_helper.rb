# frozen_string_literal: true

require 'bundler/setup'
require 'mutils'
require 'coveralls'
require 'benchmark'
require 'rspec-benchmark'

Coveralls.wear!

RSpec.configure do |config|
  config.include RSpec::Benchmark::Matchers
  config.example_status_persistence_file_path = '.rspec_status'
  config.disable_monkey_patching!
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
  if ENV['PERFORMANCE_ONLY'] == 'true' || ENV['PERFORMANCE_ONLY'] == true
    config.filter_run_excluding general: true
  end
  if ENV['TRAVIS'] == 'true' || ENV['TRAVIS'] == true
    config.filter_run_excluding performance: true
  end
end
