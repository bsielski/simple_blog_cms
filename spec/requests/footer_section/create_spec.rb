require "rails_helper"

RSpec.describe "Create FooterSection", :type => :request do
  include Devise::Test::IntegrationHelpers

  let (:user_with_role) do
    Role.create! name: "can_create_footer_sections"
    user = Admin.new(email: "withrole@example.com", password: "ihavearole123", password_confirmation: "ihavearole123")
    user.add_role :can_create_footer_sections
    user
  end

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
  end

  context "whan sign sign in as user with creating permission" do
    before do
      sign_in user_with_role
    end

    it "creates one footer_section" do
      footer_section_number = FooterSection.count
      post "/admin/footer_sections", params: { footer_section: {content: "Copyright 40 000", position: 1} } 
      number_of_new_footer_sections = FooterSection.count - footer_section_number
      expect(number_of_new_footer_sections).to eq 1
    end
  end
end
