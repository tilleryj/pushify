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
        f.write("\n\ngroup :development do\n  gem 'pushify'\nend\n")
      end
      
      split_on = "Demo3::Application.configure do"
      parts = File.read('config/environments/development.rb').split(split_on)
      
      File.open('config/environments/development.rb', "w") do |f|
        f.puts parts.join(split_on + "\n\n  config.middleware.use Pushify::Rack")
      end
      true
    end
  end
end