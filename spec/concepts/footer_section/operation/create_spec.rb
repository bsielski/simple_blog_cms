require "rails_helper"

describe FooterSection::Create do
  subject (:result) {
    described_class.(params: params, current_user: user)
  }

  let (:user_with_role) do
    Role.create! name: "can_create_footer_sections"
    user = Admin.new(email: "withrole@example.com", password: "ihavearole123", password_confirmation: "ihavearole123")
    user.add_role :can_create_footer_sections
    user
  end

  let (:super_admin_user) do
    Role.create! name: "super_admin"
    user = Admin.new(email: "superadmin@example.com", password: "iamadmin123", password_confirmation: "iamadmin123")
    user.add_role :super_admin
    user
  end

  let (:user_without_role) do
    user = Admin.new(email: "withoutrole@example.com", password: "idonthavearole123", password_confirmation: "idonthavearole123")
    user
  end

  let (:content) { "Copyright 5000 BC" }
  let (:position) { 1 }
  
  let (:params) do
    {footer_section: {content: content, position: position}}
  end

  context "with user with role" do
    let (:user) { user_with_role }
    it "works" do
      expect(result).to be_success
    end
    it "persists model" do
      expect(result[:model]).to be_persisted
    end
    it "passes policies" do
      expect(result["result.policy.default"]).to be_success
    end
    it "has proper content" do
      expect(result[:model].content).to eq "<p>Copyright 5000 BC</p>"
    end
    it "has proper position" do
      expect(result[:model].position).to eq 1
    end    
  end

  context "with superadmin" do
    let (:user) { super_admin_user }
    it "works" do
      expect(result).to be_success
    end
    it "persists model" do
      expect(result[:model]).to be_persisted
    end
    it "passes policies" do
      expect(result["result.policy.default"]).to be_success
    end
    it "has proper content" do
      expect(result[:model].content).to eq "<p>Copyright 5000 BC</p>"
    end
    it "has proper position" do
      expect(result[:model].position).to eq 1
    end    
  end

  context "with user without role" do
    let (:user) { user_without_role }
    it "doesn't work" do
      expect(result).to be_failure
    end
    it "doesn't persists model" do
      expect(result[:model]).to_not be_persisted
    end
    it "doesn't pass policies" do
      expect(result["result.policy.default"]).to be_failure
    end
  end

  context "user not logged" do
    let (:user) { nil }
    it "fails" do
      expect(result).to be_failure
    end
    it "doesn't persists model" do
      expect(result[:model]).to_not be_persisted
    end
    it "doesn't pass policies" do
      expect(result["result.policy.default"]).to be_failure
    end
  end    
  
  context "input is missing" do
    let (:params) { {} }
    let (:user) { super_admin_user }
    it "doesn't work" do
      expect(result).to be_failure
    end
    it "doesn't persists model" do
      expect(result[:model]).to_not be_persisted
    end
  end

  context "content is an empty string" do
    let (:user) { super_admin_user }
    let (:content) { "" }
    it "is valid" do
      expect(result).to be_success
    end
    it "persists model" do
      expect(result[:model]).to be_persisted
    end
    it "passes policies" do
      expect(result["result.policy.default"]).to be_success
    end
    it "has proper content" do
      expect(result[:model].content).to eq ""
    end
    it "has proper position" do
      expect(result[:model].position).to eq 1
    end    
  end

  context "content is nil" do
    let (:user) { super_admin_user }
    let (:content) { nil }
    it "create empty content" do
      expect(result).to be_success
    end
    it "persists model" do
      expect(result[:model]).to be_persisted
    end
    it "passes policies" do
      expect(result["result.policy.default"]).to be_success
    end
    it "has proper content" do
      expect(result[:model].content).to eq ""
    end
    it "has proper position" do
      expect(result[:model].position).to eq 1
    end    
  end

  context "position is nil" do
    let (:user) { super_admin_user }
    let (:position) { nil }
    it "create empty content" do
      expect(result).to be_success
    end
    it "persists model" do
      expect(result[:model]).to be_persisted
    end
    it "passes policies" do
      expect(result["result.policy.default"]).to be_success
    end
    it "has proper content" do
      expect(result[:model].content).to eq "<p>Copyright 5000 BC</p>"
    end
    it "has proper position" do
      expect(result[:model].position).to eq 1
    end    
  end
end
