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
      description: "Some description",
      stylesheet: Stylesheet.last
    )
  end

  it 'is valid when every fields are OK' do
    expect(subject).to be_valid
  end

  it "fails with a description longer than 150 characters" do
    subject.description = "C" * 151
    expect(subject).to be_invalid
  end

  it "is valid with a description 150 characters long" do
    subject.description = "C" * 150
    expect(subject).to be_valid
  end

  it "fails when a description is an empty string" do
    subject.description = ""
    expect(subject).to be_invalid
  end

  it "is valid when a description is nil" do
    subject.description = nil
    expect(subject).to be_valid
  end

  it "is stripped and squeeze whiespaces in the description before validation" do
    subject.description = "\t    \n\n   \nSuper  \t\n\ site\n\n\n\n"
    subject.save!
    expect(Site.last.description).to be == "Super site"
  end

  after(:context) do
    Stylesheet.destroy_all
    Site.destroy_all

  end

end
