require "rails_helper"

RSpec.describe "Destroy FooterSection", :type => :request do
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
    FooterSection.create!(
      position: 1,
      content: Convert.to_html("Powered by Simple Blog CMS (beta)\n\nwhich is powered by Ruby on Rails")
    )
    Role.create! name: "can_destroy_footer_sections"
    Role.create! name: "can_nothing"
  end

  let (:id) { FooterSection.last.id }
  let (:user) do
    user = Admin.new(email: "user@example.com", password: "ihavearole123", password_confirmation: "ihavearole123")
    user.add_role role
    user
  end

  context "user with destroying permission" do
    let (:role) { :can_destroy_footer_sections }
    before do
      sign_in user 
      delete "/admin/footer_sections/#{id}", params: { }
    end
    it "deletes footer section" do
      expect(FooterSection.pluck(:id)).to_not include id
    end
    it "redirect to index footer section page" do
      expect(response).to redirect_to "/admin/footer_sections"
    end
  end

  context "user without destroying permission" do
    let (:role) { :can_nothing }
    before do
      sign_in user 
      delete "/admin/footer_sections/#{id}", params: { }
    end
    it "doesn't delete footer section" do
      expect(FooterSection.pluck(:id)).to include id
    end
    it "render delete view" do
      expect(response.body).to include("Delete footer section: 1")
    end
  end
end
