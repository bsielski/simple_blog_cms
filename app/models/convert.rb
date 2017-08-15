require 'markdown'
require 'reverse_markdown'

module Convert

  def self.to_markdown(html)
    ReverseMarkdown.convert html, github_flavored: true
  end

  def self.to_html(markdown)
    if markdown
      return Markdown.new(markdown).to_html.gsub(/<!--[^>]*-->/, "").strip#.gsub("\n\n","\n")
    else
      return ""
    end
  end

end
