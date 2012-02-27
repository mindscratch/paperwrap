require 'rubypants'

module Paperwrap
  module Extensions
    class SmartyHTML
      def initialize(html, options=[1])
        @pants = RubyPants.new html, options
      end

      def to_html
        @pants.to_html
      end
    end
  end
end