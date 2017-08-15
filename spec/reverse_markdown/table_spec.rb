require 'rails_helper'

RSpec.describe Convert, :type => :model do

  it 'respects align center style' do
    html = <<-THESTRING
<table>
  <thead>
    <tr>
      <th>table</th>
      <th style="text-align: center">test of justify</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>a cell</td>
      <td style="text-align: center">center</td>
    </tr>
  </tbody>
</table>
THESTRING
    expect(Convert.to_markdown(html)).to be == "| table | test of justify |\n| ---- | :--: |\n| a cell | center |\n\n"
  end



  # it 'converts multiple lines of Ruby <pre><code>' do
  #   html = "<pre><code>proc = Proc.new\n\n# after one empty line</code></pre>"
  #   expect(Convert.to_markdown(html)).to be == "```\nproc = Proc.new\n\n# after one empty line\n```\n"
  # end

end
