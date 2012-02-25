require 'spec_helper'
require 'paperwrap/markdown'

module Paperwrap
  describe Markdown do

    context "given Markdown formatted text" do
      it "generates HTML" do
        m = Paperwrap::Markdown.new "* foo\n* bar"
        html = m.to_html
        match = html.match /(<li>)+/

        match.should_not be_nil
        match.size.should eq 2
      end
    end

    context "given plain text" do
      it "generates paragraph html tags" do
        input = "hello world"
        m = Paperwrap::Markdown.new input
        html = m.to_html
        html.should eq("<p>#{input}</p>\n")
      end
    end

  end
end