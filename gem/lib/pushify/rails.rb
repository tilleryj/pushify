require "pushify"
require "pushify/rack"

module Pushify
  module Rails
    def self.initialize
      ActionView::Base.send(:include, Pushify::Helper)
      

      if (::Rails.version.start_with?("2"))
        if defined?(::Rails.configuration) && ::Rails.configuration.respond_to?(:middleware)
          ::Rails.configuration.middleware.use("Pushify::Rack")
        end
      end
    end
    
    class Assets
      
      def self.path_to_asset(asset)
        File.join(File.dirname(__FILE__), "..", "..", "install", asset)
      end
      
      def self.assets
        {
          "/pushify/pushify.js" => ["text/application", "pushify.js"],
          "/pushify/juggernaut.swf" => ["application/x-shockwave-flash", "juggernaut.swf"],
          "/pushify/expressinstall.swf" => ["application/x-shockwave-flash", "/pushify/expressinstall.swf"]
        }
      end
      
      def self.asset_body(asset)
        if (asset == "pushify.js")
          [
            File.open(self.path_to_asset("json.js")).read, 
            File.open(self.path_to_asset("swfobject.js")).read, 
            File.open(self.path_to_asset("juggernaut.js")).read, 
            File.open(self.path_to_asset("pushify.js")).read,
            Pushify.juggernaut_src
          ].join("\n\n")
        else
          File.open(self.path_to_asset(asset)).read
        end
      end
      
      def self.just_the_path(path)
        m = path.match(/https?:\/\/[-A-Za-z0-9\.:]*(\/.*)/)
        m ? m[1] : path
      end
      
      def self.includes?(path)
        self.assets.keys.include?(just_the_path(path))
      end
      
      def self.response(path)
        asset = self.assets[just_the_path(path)]
        [200, {"Content-Type" => asset[0]}, [self.asset_body(asset[1])]]
      end
    end
  end
end

Pushify::Rails.initialize
