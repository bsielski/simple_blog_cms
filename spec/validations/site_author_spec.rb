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
      keywords: "",
      description: "",
      stylesheet: Stylesheet.last
    )
  end

  it 'is valid when every fields are OK' do
    expect(subject).to be_valid
  end

  it "fails with an author longer than 56 characters" do
    subject.author = "C" * 57
    expect(subject).to be_invalid
  end

  it "is valid with an author 56 characters long" do
    subject.author = "C" * 56
    expect(subject).to be_valid
  end

  it "is valid when an author is an empty string" do
    subject.author = ""
    expect(subject).to be_valid
  end

  it "is valid when an author is nil" do
    subject.author = nil
    expect(subject).to be_valid
  end

  it "is stripped and squeeze whiespaces in the author before validation" do
    subject.author = "\t\t\n\t   \nJohn  \n\t\  \n Smith  \n\n\n"
    subject.save!
    expect(Site.last.author).to be == "John Smith"
  end

  after(:context) do
    Stylesheet.destroy_all
    Site.destroy_all

  end

end
