require 'markdown'
require 'reverse_markdown'

module Convert

  def self.ths_to_code(ths)
    code = ""
    ths.each do |th|
      if th.include? "text-align: center"
        code += "C"
      elsif th.include? "text-align: left"
        code += "L"
      elsif th.include? "text-align: right"
        code += "R"
      else
        code += "N"
      end
    end
    code
  end

  def self.fix_tables(markdown, code)
    fixed_markdown = markdown
    code.each_char do |char|
      if char == "L"
        fixed_markdown.sub!("| --- ", "| :--- ")
      elsif char == "C"
        fixed_markdown.sub!("| --- ", "| :--: ")
      elsif char == "R"
        fixed_markdown.sub!("| --- ", "| ---: ")
      else
        fixed_markdown.sub!("| --- ", "| ---- ")
      end
    end
    fixed_markdown
  end

  def self.extract_alignment(html)
    html_doc = Nokogiri::HTML(html)
    theads = html_doc.xpath("//thead")
    ths = theads.to_s.scan(/<th>|<th [^\>]*>/)
    ths_to_code(ths)
  end


  def self.to_markdown(html)
    code = extract_alignment(html)
    markdown = ReverseMarkdown.convert html, github_flavored: true
    markdown = fix_tables(markdown, code)
    markdown
  end

  def self.to_html(markdown)
    if markdown
      return Markdown.new(markdown).to_html.gsub(/<!--[^>]*-->/, "").strip#.gsub("\n\n","\n")
    else
      return ""
    end
  end

end
