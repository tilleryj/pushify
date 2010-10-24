require "pushify/helper"
require "pushify/rails"
require "pushify/juggernaut"

module Pushify # :nodoc:
  def self.install
    ActionView::Base.send(:include, Pushify::Helper)
  end
end
