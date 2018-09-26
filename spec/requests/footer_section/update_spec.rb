require "rails_helper"

RSpec.describe "Update FooterSection", :type => :request do
  include Devise::Test::IntegrationHelpers

  let (:last_id) do
    FooterSection.last.id
  end

  let (:user_with_role) do
    Role.create! name: "can_update_footer_sections"
    user = Admin.new(email: "withrole@example.com", password: "ihavearole123", password_confirmation: "ihavearole123")
    user.add_role :can_update_footer_sections
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
    FooterSection.create!(
      position: 1,
      content: Convert.to_html("Powered by Simple Blog CMS (beta)\n\nwhich is powered by Ruby on Rails")
    )
  end

  context "whan sign sign in as user with updating permission" do
    before do
      sign_in user_with_role
    end
    it "doesn't create new footer_section" do
      footer_section_number = FooterSection.count
      patch "/admin/footer_sections/#{last_id}", params: { footer_section: {content: "Copyright 40 000", position: 1} } 
      number_of_new_footer_sections = FooterSection.count - footer_section_number
      expect(number_of_new_footer_sections).to eq 0
    end
    it "modify footer_section content" do
      patch "/admin/footer_sections/#{last_id}", params: { footer_section: {content: "Copyright 40 000", position: 1} } 
      expect(FooterSection.find(last_id).content).to eq "<p>Copyright 40 000</p>"
    end

  end
end
