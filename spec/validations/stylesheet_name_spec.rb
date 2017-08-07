require 'rails_helper'

RSpec.describe Stylesheet, :type => :model do

  let(:css) { <<-THESTRING
/* PAGE */
body {
  background-color: black;
  margin: 0;
}
.page_container {
  max-width: 750px;
  margin: 0 auto;
  padding: 5px 20px;
  background-color: #ffffee;
}
THESTRING
  }

  it 'is valid when every fields are OK' do
    stylesheet = Stylesheet.new name: "Custom stylesheet", content: css
    expect(stylesheet).to be_valid
  end

  it "fails with a name longer than 56 characters" do
    stylesheet = Stylesheet.new name: "C" * 57, content: css
    expect(stylesheet).to be_invalid
  end

  it "is valid with a name 56 characters long" do
    stylesheet = Stylesheet.new name: "C" * 56, content: css
    expect(stylesheet).to be_valid
  end

  it "fails when a name is an empty string" do
    stylesheet = Stylesheet.new name: "", content: css
    expect(stylesheet).to be_invalid
  end

  it "fails when a name is nil" do
    stylesheet = Stylesheet.new name: nil, content: css
    expect(stylesheet).to be_invalid
  end

  it "fails with not unique name" do
    Stylesheet.create name: "Custom stylesheet", content: css
    stylesheet = Stylesheet.new name: "Custom stylesheet", content: css
    expect(stylesheet).to be_invalid
  end

  it "is stripped and squeeze whiespaces in names before validation" do
    Stylesheet.create name: "\t\t\n\n\n   \nCustom  \t\n\ stylesheet\n\n\n\n", content: css
    expect(Stylesheet.last.name).to be == "Custom stylesheet"
  end


end
