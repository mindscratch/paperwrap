require 'java'

jars_path = File.join(File.dirname(__FILE__), '..', '..', 'ext', 'java', 'jar')
Dir.glob("#{jars_path}/**/*.jar").each {|jar| require jar}

module Paperwrap
  class Markdown

    HTML_EXT_MAP = {
      :smart => Paperwrap::Extensions::SmartyHTML
    }

    def initialize(text, *extensions)
      @text = text
      @html_extensions = prepare_html_extensions(extensions) || []
    end

    def to_html
      # convert the Markdown text into HTML
      reader = java.io.StringReader.new @text
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

      # apply html extensions
      apply_html_extensions html
    end

    #########
    protected
    #########

    def prepare_html_extensions(extensions)
      result = nil
      unless extensions.nil? || extensions.empty?
        result = extensions.map do |ext|
          HTML_EXT_MAP.fetch(ext, nil)
        end.compact.uniq
      end
      result
    end

    def apply_html_extensions(html)
      @html_extensions.inject(html) do |extended_html, extension_class|
        apply_html_extension extension_class, extended_html
      end
    end

    def apply_html_extension(html_extension_class, html)
      html_extension_class.new(html).to_html
    end
  end
end