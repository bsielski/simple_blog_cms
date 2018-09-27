require "rails_helper"

describe FooterSection::Index do

  subject (:result) {
    described_class.()
  }

  before do
    create_footer_sections
  end

  context "with three sections" do
    let (:create_footer_sections) {
      FooterSection.create!(
        position: 1,
        content: Convert.to_html("first")
      )
      FooterSection.create!(
        position: 2,
        content: Convert.to_html("second")
      )
      FooterSection.create!(
        position: 2,
        content: Convert.to_html("third")
      )
    }
    it "is success" do
      expect(result).to be_success
    end
    it "returns 3 objects" do
      expect(result[:model].size).to eq 3
    end
    it "has proper order" do
      expect(result[:model].map{|f| f.content})
        .to eq ["<p>first</p>", "<p>third</p>", "<p>second</p>"]
    end
  end

  context "without sections" do
    let (:create_footer_sections) {
    }
    it "is success" do
      expect(result).to be_success
    end
    it "returns 0 objects" do
      expect(result[:model].size).to eq 0
    end
  end
end
