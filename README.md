Paperwrap
=========

A JRuby wrapper around the [MarkdownPapers](https://github.com/lruiz/MarkdownPapers) Java library.

This wrapper was created so it could be used as a Markdown processor in the [rocco](https://github.com/rtomayko/rocco) documentation library.

Usage
-----

````ruby
# get some Markdown text
markdown_file = "" # file with markdown
markdown_text = File.open(markdown_file).read

# create the processor
m = Paperwrap::Markdown.new markdown_text

# generate HTML
html = m.to_html

# save it
File.open('sample.html', 'w') do |fh|
  fh.write html
end
````