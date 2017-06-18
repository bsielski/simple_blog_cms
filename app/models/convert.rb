require 'markdown'
require 'reverse_markdown'

module Convert

  def self.to_markdown(html)
    ReverseMarkdown.convert html
  end

  def self.to_html(markdown)
    Markdown.new(markdown).to_html.gsub(/<!--[^>]*-->/, "").strip.gsub("\n\n","\n")
  end
  
end
