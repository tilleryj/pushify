require "yaml"
require "socket"
require "erb"

module Pushify # :nodoc:
  module Helper

    def pushify
      Pushify.javascript_src
    end
    
  end

  def self.javascript_src
    '<script type="text/javascript" src="/pushify/pushify.js"></script>'
  end
  
  def self.juggernaut_src(options = {})
    hosts = Pushify::Juggernaut::CONFIG[:hosts].select {|h| !h[:environment] or h[:environment] == ENV['RAILS_ENV'].to_sym }
    random_host = hosts[rand(hosts.length)]
    options = {
      :host                 => (random_host[:public_host] || random_host[:host]),
      :port                 => (random_host[:public_port] || random_host[:port]),
      :width                => '0px',
      :height               => '0px',
      :swf_address          => "/pushify/juggernaut.swf",
      :ei_swf_address       => "/pushify/expressinstall.swf",
      :flash_version        => 8,
      :flash_color          => "#fff",
      :swf_name             => "juggernaut_flash",
      :bridge_name          => "juggernaut",
      :debug                => false,
      :reconnect_attempts   => 3,
      :reconnect_intervals  => 3
    }.merge(options)

    "new Juggernaut(#{options.to_json});"
  end
end
