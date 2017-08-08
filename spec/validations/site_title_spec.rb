require 'rails_helper'

RSpec.describe Site, :type => :model do

  before(:context) do
    css = <<-THESTRING
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
    Stylesheet.create name: "Custom stylesheet", content: css
  end

  subject do
    Site.new(
      title: "Some Title",
      author: "",
      description: nil,
      stylesheet: Stylesheet.last
    )
  end

  it 'is valid when every fields are OK' do
    expect(subject).to be_valid
  end

  it "fails with a title longer than 56 characters" do
    subject.title = "C" * 57
    expect(subject).to be_invalid
  end

  it "is valid with a title 56 characters long" do
    subject.title = "C" * 56
    expect(subject).to be_valid
  end

  it "fails when a title is an empty string" do
    subject.title = ""
    expect(subject).to be_invalid
  end

  it "fails when a title is nil" do
    subject.title = nil
    expect(subject).to be_invalid
  end

  it "is stripped and squeeze whiespaces in the title before validation" do
    subject.title = "\t\t\n\n\n   \nSuper  \t\n\ site\n\n\n\n"
    subject.save!
    expect(Site.last.title).to be == "Super site"
  end

  after(:context) do
    Stylesheet.destroy_all
    Site.destroy_all

  end

end
