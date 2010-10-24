require 'fileutils'

module Pushify
  module Install
    def self.install!
      return false if File.open('config/environments/development.rb', 'r').read.match(/\s*config\.gem\s+['"]pushify['"]/)
      
      File.open('config/environments/development.rb', 'a') do |f|
        f.write("\n\nconfig.gem 'pushify'\n")
      end
      true
    end
  end
end