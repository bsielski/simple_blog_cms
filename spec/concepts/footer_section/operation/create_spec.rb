require "rails_helper"

describe FooterSection::Create do
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
    {category: {content: content, position: position}}
  end

  it "works for user with role" do
    result = FooterSection::Create.(params: params, current_user: user_with_role)
    expect(result).to be_success
    expect(result[:model]).to be_persisted
    expect(result[:model].content).to eq "Copyright 5000 BC"
    expect(result[:model].position).to eq 1
    expect(result["result.policy.default"]).to be_success
  end

  it "works for superadmin" do
    result = FooterSection::Create.(params: params, current_user: super_admin_user)
    expect(result).to be_success
    expect(result[:model]).to be_persisted
    expect(result[:model].content).to eq "Copyright 5000 BC"
    expect(result[:model].position).to eq 1
    expect(result["result.policy.default"]).to be_success
  end

  it "doesn't work for user without role" do
    result = FooterSection::Create.(params: params, current_user: user_without_role)
    expect(result).to be_failure
    expect(result["result.policy.default"]).to be_failure
  end
  
  context "user not logged" do
    it "fails" do
      result = FooterSection::Create.(params: params, current_user: nil)
      expect(result).to be_failure
      expect(result[:model]).to_not be_persisted
      expect(result["result.policy.default"]).to be_failure
    end
  end

  context "input is missing" do
    let (:params) { {} }
    it "doesn't work" do
      result = FooterSection::Create.(params: params, current_user: super_admin_user)
      expect(result).to be_failure
      expect(result[:model]).to_not be_persisted
    end
  end

  context "description is an empty string" do
    let (:description) { "" }
    it "is valid" do
      result = FooterSection::Create.(params: params, current_user: super_admin_user)
      expect(result).to be_success
      expect(result[:model]).to be_persisted
      expect(result[:model].content).to eq ""
      expect(result[:model].position).to eq 1
      expect(result["result.policy.default"]).to be_success
    end
  end

  context "description is nil" do
    let (:description) { nil }
    it "create empty description" do
      result = FooterSection::Create.(params: params, current_user: super_admin_user)
      expect(result).to be_success
      expect(result[:model]).to be_persisted
      expect(result[:model].content).to eq ""
      expect(result[:model].position).to eq 1
      expect(result["result.policy.default"]).to be_success
    end
  end

  context "position is nil" do
    let (:position) { nil }
    it "create empty description" do
      result = FooterSection::Create.(params: params, current_user: super_admin_user)
      expect(result).to be_success
      expect(result[:model]).to be_persisted
      expect(result[:model].content).to eq "Copyright 5000 BC"
      expect(result[:model].position).to eq 1
      expect(result["result.policy.default"]).to be_success
    end
  end
end
