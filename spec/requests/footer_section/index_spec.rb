require "rails_helper"

RSpec.describe "Index FooterSection", :type => :request do
  include Devise::Test::IntegrationHelpers
  
  before do
    Stylesheet.create!(
      name: "Default style",
      content: Stylesheet::DefaultStylesheet.content
    )
    Site.create!(
      title: "Simple Blog CMS",
      author: "",
      description: "A demo of the betha version of a blog CMS called \"Simple Blog CMS\".",
      stylesheet: Stylesheet.first
    )
    create_footer_sections
    get "/admin/footer_sections", params: {} 
  end

  RSpec.shared_examples "displays basic elements" do
    it { expect(response.body).to include "Manage footer section" }
    it { expect(response.body).to include "Id" }
    it { expect(response.body).to include "Position" }
    it { expect(response.body).to include "Contains" }
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
    include_examples "displays basic elements"
    it { expect(response.body).to match /first.*third.*second/m }
  end
end
