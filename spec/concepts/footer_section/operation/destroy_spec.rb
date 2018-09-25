require "rails_helper"

describe FooterSection::Destroy do

  subject (:result) {
    described_class.(params: params, current_user: user)
  }
  let (:params) do
    {
      id: id
    }
  end

  let (:footer_section) do
    FooterSection.create!(
      position: 1,
      content: Convert.to_html("Powered by Simple Blog CMS (beta)\n\nwhich is powered by Ruby on Rails")
    )
  end

  let (:id) do
    footer_section.id
  end

  let (:can_delete_footer_sections) {
    Role.create! name: "can_delete_footer_sections"
    :can_delete_footer_sections
  }

  let (:super_admin) {
    Role.create! name: "super_admin"
    :super_admin
  }

  let (:useless_role) {
    Role.create! name: "can_nothing"
    :can_nothing
  }

  let (:user) do
    user = Admin.new(email: "withrole@example.com", password: "ihavearole123", password_confirmation: "ihavearole123")
    user.add_role role
    user
  end

  context "with user with role" do
    let (:role) { can_delete_footer_sections }
    it "is success" do
      expect(result).to be_success
    end
    it "passes policies" do
      expect(result["result.policy.destroying"]).to be_success
    end
  end

  context "with user superadmin" do
    let (:role) { super_admin }
    it "is success" do
      expect(result).to be_success
    end
    it "passes policies" do
      expect(result["result.policy.destroying"]).to be_success
    end
  end

  context "with user with useless role" do
    let (:role) { useless_role }
    it "fails" do
      expect(result).to be_failure
    end
    it "doesn't pass policies" do
      expect(result["result.policy.destroying"]).to be_failure
    end
  end

  context "user not logged" do
    let (:user) { nil }
    it "fails" do
      expect(result).to be_failure
    end
    it "doesn't pass policies" do
      expect(result["result.policy.destroying"]).to be_failure
    end
  end    
  
  context "id is missing" do
    let (:id) { nil }
    let (:role) { super_admin }
    it "fails" do
      expect(result).to be_failure
    end
  end
end
