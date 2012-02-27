require 'spec_helper'
require 'paperwrap'

module Paperwrap::Extensions
  describe SmartyHTML do

    context "given :smart option" do
      it "generates HTML with SmartyPants extension applied" do
        text = "Hello 'this' is a test!"
        m = Paperwrap::Markdown.new text, :smart
        html = m.to_html
        first_quote = html.index("&#8216;")
        last_quote = html.index("&#8217;")
        first_quote.should be > 0
        last_quote.should be > first_quote
      end
    end

  end
end