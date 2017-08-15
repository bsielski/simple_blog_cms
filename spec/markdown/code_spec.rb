require 'rails_helper'

RSpec.describe Convert, :type => :model do

  it 'converts one line of Ruby code to <pre><code>' do
    markdown = "```\nproc = Proc.new\n```\n"
    expect(Convert.to_html(markdown)).to be == "<pre><code>proc = Proc.new\n</code></pre>"
  end

  it 'converts multiple lines of Ruby code to HTML' do
    markdown = "```\nproc = Proc.new\n\n# after one empty line\n```\n"
    expect(Convert.to_html(markdown)).to be == "<pre><code>proc = Proc.new\n\n# after one empty line\n</code></pre>"
  end

end
