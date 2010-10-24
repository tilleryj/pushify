require 'fileutils'

module Pushify
  module Install
    
    def self.install_from
      File.join(File.dirname(__FILE__), "..", "..", "install")
    end
    
    def self.install_to
      Dir.pwd
    end
    
    def self.install!
      FileUtils.mkdir_p(File.join(install_to, "public", "pushify"))
      FileUtils.mkdir_p(File.join(install_to, "public", "javascripts", "pushify"))

      puts "Installing Pushify..."
      FileUtils.cp(File.join(install_from, "swfobject.js")      , File.join(install_to, "public", "javascripts", "pushify"))
      FileUtils.cp(File.join(install_from, "juggernaut.js")     , File.join(install_to, "public", "javascripts", "pushify"))
      FileUtils.cp(File.join(install_from, "pushify.js")       , File.join(install_to, "public", "javascripts", "pushify"))
      FileUtils.cp(File.join(install_from, "juggernaut.swf")    , File.join(install_to, "public", "pushify"))
      FileUtils.cp(File.join(install_from, "expressinstall.swf"), File.join(install_to, "public", "pushify"))

      FileUtils.cp(File.join(install_from, "juggernaut_hosts.yml"), File.join(install_to, "config")) unless File.exist?(File.join(install_to, "config", "juggernaut_hosts.yml"))
      FileUtils.cp(File.join(install_from, "juggernaut.yml"), File.join(install_to, "config")) unless File.exist?(File.join(install_to, "config", "juggernaut.yml"))

      File.open('config/environments/development.rb', 'a') do |f|
        f.write("\n\nconfig.gem 'pushify'\n")
      end
      FileUtils.cp(File.join(install_from, "pushify_initializer.rb"), File.join(install_to, "config", "initializers")) 

      puts "Pushify has been successfully installed."
      puts ""
      puts IO.read(File.join(File.dirname(__FILE__), "..", 'README.markdown'))
      puts ""
    end
  end
end