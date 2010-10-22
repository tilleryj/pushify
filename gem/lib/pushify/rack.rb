module Pushify
  class Rack
    def initialize(app)
      @app = app
    end
    
    def call(env)
      path = env["REQUEST_URI"]
      
      if (Pushify::Rails::Assets.includes?(path))
        Pushify::Rails::Assets.response(path)
      else
        @app.call(env)
      
        # status, headers, response = @app.call(env)
        # if (headers["Content-Type"].include? "text/html")
        #   [200, {"Content-Type" => "text/html"}, []]
        # else
        #   [status, headers, response]
        # end
      end
    end
  end
end
