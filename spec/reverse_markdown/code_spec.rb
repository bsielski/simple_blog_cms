require 'rails_helper'

RSpec.describe Convert, :type => :model do

  it 'converts one line of Ruby <pre><code>' do
    html = "<pre><code>proc = Proc.new\n</code></pre>"
    expect(Convert.to_markdown(html)).to be == "```\nproc = Proc.new\n```\n"
  end

  it 'converts multiple lines of Ruby <pre><code>' do
    html = "<pre><code>proc = Proc.new\n\n# after one empty line</code></pre>"
    expect(Convert.to_markdown(html)).to be == "```\nproc = Proc.new\n\n# after one empty line\n```\n"
  end

end
