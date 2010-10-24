require "yaml"
require "socket"
require "erb"
require "json"

module Pushify # :nodoc:
  def self.install
    ActionView::Base.send(:include, Pushify::Helper)
  end

  module Helper

    def pushify(options = {})

      hosts = Juggernaut::CONFIG[:hosts].select {|h| !h[:environment] or h[:environment] == ENV['RAILS_ENV'].to_sym }
      random_host = hosts[rand(hosts.length)]
      options = {
        :host                 => (random_host[:public_host] || random_host[:host]),
        :port                 => (random_host[:public_port] || random_host[:port]),
        :width                => '0px',
        :height               => '0px',
        :session_id           => request.session_options[:id],
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
      <<-HTML
        #{ javascript_include_tag "pushify/pushify" }
        #{ javascript_tag "new Juggernaut(#{options.to_json});" }
      HTML
    end
  end
end

