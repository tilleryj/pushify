require "pushify"
require "pushify/rack"

module Pushify
  module Rails
    def self.initialize
      ActionView::Base.send(:include, Pushify::Helper)
      
      ::Rails.configuration.middleware.use("Pushify::Rack")
    end
    
    class Assets
      
      def self.path_to_asset(asset)
        File.join(File.dirname(__FILE__), "..", "..", "install", asset)
      end
      
      def self.assets
        {
          "/javascripts/pushify/pushify.js" => ["text/application", "pushify.js"],
          "/pushify/juggernaut.swf" => ["application/x-shockwave-flash", "juggernaut.swf"],
          "/pushify/expressinstall.swf" => ["application/x-shockwave-flash", "/pushify/expressinstall.swf"]
        }
      end
      
      def self.asset_body(asset)
        if (asset == "pushify.js")
          [
            File.open(self.path_to_asset("swfobject.js")).read, 
            File.open(self.path_to_asset("juggernaut.js")).read, 
            File.open(self.path_to_asset("pushify.js")).read
          ].join("\n\n")
        else
          File.open(self.path_to_asset(asset)).read
        end
      end
      
      def self.includes?(path)
        self.assets.keys.include?(path)
      end
      
      def self.response(path)
        asset = self.assets[path]
        [200, {"Content-Type" => asset[0]}, [self.asset_body(asset[1])]]
      end
    end
  end
end

Pushify::Rails.initialize
