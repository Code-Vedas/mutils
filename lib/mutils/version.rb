# frozen_string_literal: true

# Version
module Mutils
  version_file_path = File.join(File.dirname(__FILE__), '../../Version')
  VERSION = File.read(version_file_path).split("\n").first.gsub('v', '')
end
