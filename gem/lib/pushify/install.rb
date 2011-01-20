require 'fileutils'

module Pushify
  module Install
    def self.install!
      File.exist?(File.join(Dir.pwd, "Gemfile")) ? self.install_3! : self.install_2!
    end
    
    def self.install_2!
      return false if File.open('config/environments/development.rb', 'r').read.match(/\s*config\.gem\s+['"]pushify['"]/)
      
      File.open('config/environments/development.rb', 'a') do |f|
        f.write("\n\nconfig.gem 'pushify'\n")
      end
      true
    end
    
    def self.install_3!
      return false if File.open('Gemfile', 'r').read.match(/\s*gem\s+['"]pushify['"]/)
      
      File.open('Gemfile', 'a') do |f|
        f.write("\n\ngem 'pushify'\n")
      end
      true
    end
  end
end