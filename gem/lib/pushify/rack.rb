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
        status, headers, response = @app.call(env)

        is_html = !response.is_a?(Array) && (headers["Content-Type"].nil? || headers["Content-Type"].include?("text/html"))
        if (is_html && response.body.match(/<\/body>/))
          pushify_src = Pushify.javascript_src
          response.body = response.body.gsub(/(<\/body>)/, "#{pushify_src}</body>")
          headers["Content-Length"] = (response.body.size).to_s
        end

        [status, headers, response]
      end
    end
  end
end
