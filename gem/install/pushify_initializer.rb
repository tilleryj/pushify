if defined?(Pushify)
  Pushify.install
else
  module Pushify
    module Helper
      def pushify *args
        ""
      end
    end
  end
  ActionView::Base.send(:include, Pushify::Helper)
end


