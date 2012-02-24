jars_path = File.join(File.dirname(__FILE__), '..', '..', 'ext', 'java', 'jar')
Dir.glob("#{jars_path}/**/*.jar").each {|jar| puts "load #{jar}"; require jar}

module Paperwrap
  class Markdown
    def initialize(text, *extensions)
      @text = text
      # TODO support extensions (such as :smarty)
    end

    def to_html
      reader = java.io.StringReader.new text
      writer = java.io.StringWriter.new
      html = ''
      begin
        m = org.tautua.markdownpapers.Markdown.new
        m.transform reader, writer
        writer.flush
      ensure
        reader.close if reader
        writer.close if writer
      end
      html = writer.to_string
    end
  end
end