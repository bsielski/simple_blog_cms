require "rails_helper"

describe Category::Create do
  let (:user_with_role) do
    Role.create! name: "can_create_categories"
    user = Admin.new(email: "withrole@example.com", password: "ihavearole123", password_confirmation: "ihavearole123")
    user.add_role :can_create_categories
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

  let (:name) { "News" }
  let (:description) { "Only newest news!" }
  let (:visibility) { "invisible" }
  let (:position) { 1 }
  
  let (:params) do
    {category: {name: name, description: description, visibility: visibility, position: position}}
  end

  it "works for user with role" do
    result = Category::Create.(params: params, current_user: user_with_role)
    expect(result).to be_success
    expect(result[:model]).to be_persisted
    expect(result[:model].name).to eq "News"
    expect(result[:model].description).to eq "Only newest news!"
    expect(result[:model].visibility).to eq "invisible"
    expect(result[:model].position).to eq 1
    expect(result["result.policy.default"]).to be_success
  end

  it "works for superadmin" do
    result = Category::Create.(params: params, current_user: super_admin_user)
    expect(result).to be_success
    expect(result[:model]).to be_persisted
    expect(result[:model].name).to eq "News"
    expect(result[:model].description).to eq "Only newest news!"
    expect(result[:model].visibility).to eq "invisible"
    expect(result[:model].position).to eq 1
    expect(result["result.policy.default"]).to be_success
  end

  it "doesn't work for user without role" do
    result = Category::Create.(params: params, current_user: user_without_role)
    expect(result).to be_failure
    expect(result["result.policy.default"]).to be_failure
  end

  context "without visibility" do
    let (:visibility) { nil }
    it "doesn't work" do
      result = Category::Create.(params: params, current_user: super_admin_user)
      expect(result).to be_failure
      expect(result[:model]).to_not be_persisted
      expect(result["result.contract.default"].errors.messages).to eq({:visibility => ["must be equal to invisible or must be equal to visible"]})
    end
  end

  context "with visible visibility" do
    let (:visibility) { "visible" }
    it "does work" do
      result = Category::Create.(params: params, current_user: super_admin_user)
      expect(result).to be_success
      expect(result[:model]).to be_persisted
    end
  end

  context "with int visibility" do
    let (:visibility) { 1 }
    it "doesn't work" do
      result = Category::Create.(params: params, current_user: super_admin_user)
      expect(result).to be_failure
      expect(result[:model]).to_not be_persisted
    end
  end

  context "with invalid string visibility" do
    let (:visibility) { "lol" }
    it "doesn't work" do
      result = Category::Create.(params: params, current_user: super_admin_user)
      expect(result).to be_failure
      expect(result[:model]).to_not be_persisted
    end
  end

  context "name longer than 56 characters" do
    let (:name) { "a" * 57 }
    it "doesn't work" do
      result = Category::Create.(params: params, current_user: super_admin_user)
      expect(result).to be_failure
      expect(result[:model]).to_not be_persisted
    end
  end

  context "name is 56 characters" do
    let (:name) { "b" * 56 }
    it "does work" do
      result = Category::Create.(params: params, current_user: super_admin_user)
      expect(result).to be_success
      expect(result[:model]).to be_persisted
      expect(result[:model].name).to eq "bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb"
      expect(result[:model].description).to eq "Only newest news!"
      expect(result[:model].visibility).to eq "invisible"
      expect(result[:model].position).to eq 1
      expect(result["result.policy.default"]).to be_success
    end
  end

  context "name is empty string" do
    let (:name) { "" }
    it "doesn't work" do
      result = Category::Create.(params: params, current_user: super_admin_user)
      expect(result).to be_failure
      expect(result[:model]).to_not be_persisted
    end
  end

  context "name is nil" do
    let (:name) { nil }
    it "doesn't work" do
      result = Category::Create.(params: params, current_user: super_admin_user)
      expect(result).to be_failure
      expect(result[:model]).to_not be_persisted
    end
  end

  context "name is only a space character" do
    let (:name) { " " }
    it "doesn't work" do
      result = Category::Create.(params: params, current_user: super_admin_user)
      expect(result).to be_failure
      expect(result[:model]).to_not be_persisted
    end
  end

  context "name is only a new line character" do
    let (:name) { "\n" }
    it "doesn't work" do
      result = Category::Create.(params: params, current_user: super_admin_user)
      expect(result).to be_failure
      expect(result[:model]).to_not be_persisted
    end
  end

  context "name is a mix of spaces and new lines characters" do
    let (:name) { " \n \n\n  \n" }
    it "doesn't work" do
      result = Category::Create.(params: params, current_user: super_admin_user)
      expect(result).to be_failure
      expect(result[:model]).to_not be_persisted
    end
  end
  
  context "user lot logged" do
    it "fails" do
      result = Category::Create.(params: params, current_user: nil)
      expect(result).to be_failure
      expect(result[:model]).to_not be_persisted
      expect(result["result.policy.default"]).to be_failure
    end
  end

  context "input is missing" do
    let (:params) { {} }
    it "doesn't work" do
      result = Category::Create.(params: params, current_user: super_admin_user)
      expect(result).to be_failure
      expect(result[:model]).to_not be_persisted
    end
  end

  context "with not unique name" do
    before(:each) do
      temp_params = {category: {name: name, description: "Some description", visibility: visibility, position: 2}}
      Category::Create.(params: temp_params, current_user: super_admin_user)
    end
    it "fails" do
      result = Category::Create.(params: params, current_user: super_admin_user)
      expect(result).to be_failure
      expect(result[:model]).to_not be_persisted
    end
  end

  context "whitespaces in name" do
    let (:name) { " I am the  \t\t \t first!!! \n " }
    it "is stripped and squeezed before save" do
      result = Category::Create.(params: params, current_user: super_admin_user)
      expect(result).to be_success
      expect(result[:model]).to be_persisted
      expect(result[:model].name).to eq "I am the first!!!"
      expect(result[:model].description).to eq "Only newest news!"
      expect(result[:model].visibility).to eq "invisible"
      expect(result[:model].position).to eq 1
      expect(result["result.policy.default"]).to be_success
    end
  end

  context "name differs only in whitespaces" do
    before(:each) do
      temp_params = {category: {name: "   \t\t  \n\n\nNews\n\n\n \t\t\t  \n\t \t", description: description, visibility: visibility, position: 2}}
      Category::Create.(params: temp_params, current_user: super_admin_user)
    end
    it "fails" do
      result = Category::Create.(params: params, current_user: super_admin_user)
      expect(result).to be_failure
      expect(result[:model]).to_not be_persisted
    end
  end

  context "description longer than 512 characters" do
    let (:description) { "A" * 513 }
    it "fails" do
      result = Category::Create.(params: params, current_user: super_admin_user)
      expect(result).to be_failure
      expect(result[:model]).to_not be_persisted
    end
  end

  context "description 512 characters long" do
    let (:description) { "B" * 512 }
    it "is valid" do
      result = Category::Create.(params: params, current_user: super_admin_user)
      expect(result).to be_success
      expect(result[:model]).to be_persisted
      expect(result[:model].name).to eq "News"
      expect(result[:model].description).to eq ("B" * 512)
      expect(result[:model].visibility).to eq "invisible"
      expect(result[:model].position).to eq 1
      expect(result["result.policy.default"]).to be_success
    end
  end

  context "description is an empty string" do
    let (:description) { "" }
    it "is valid" do
      result = Category::Create.(params: params, current_user: super_admin_user)
      expect(result).to be_success
      expect(result[:model]).to be_persisted
      expect(result[:model].name).to eq "News"
      expect(result[:model].description).to eq ""
      expect(result[:model].visibility).to eq "invisible"
      expect(result[:model].position).to eq 1
      expect(result["result.policy.default"]).to be_success
    end
  end

  context "description is nil" do
    let (:description) { nil }
    it "fails" do
      result = Category::Create.(params: params, current_user: super_admin_user)
      expect(result).to be_failure
      expect(result[:model]).to_not be_persisted
    end
  end

  context "not unique description" do
    before(:each) do
      temp_params = {category: {name: "Some not unique name", description: description, visibility: visibility, position: 2}}
      Category::Create.(params: temp_params, current_user: super_admin_user)
    end
    it "is valid" do
      result = Category::Create.(params: params, current_user: super_admin_user)
      expect(result[:model]).to be_persisted
      expect(result[:model].name).to eq "News"
      expect(result[:model].description).to eq "Only newest news!"
      expect(result[:model].visibility).to eq "invisible"
      expect(result[:model].position).to eq 1
      expect(result["result.policy.default"]).to be_success
    end
  end

  context "description is a mix of spaces and new lines characters" do
    let (:description) { "\tOnly    \t\t\t  newest   news!\n" }
    it "is stripped and squeeze whitespaces in description before save" do
      result = Category::Create.(params: params, current_user: super_admin_user)
      expect(result).to be_success
      expect(result[:model]).to be_persisted
      expect(result[:model].name).to eq "News"
      expect(result[:model].description).to eq "Only newest news!"
      expect(result[:model].visibility).to eq "invisible"
      expect(result[:model].position).to eq 1
      expect(result["result.policy.default"]).to be_success
    end
  end

  ##

  context "visibility is 0" do
    let (:visibility) { 0 }  
    it "fails" do
      result = Category::Create.(params: params, current_user: super_admin_user)
      expect(result).to be_failure
      expect(result[:model]).to_not be_persisted
    end
  end

  context "visibility is 1" do
    let (:visibility) { 1 }  
    it "fails" do
      result = Category::Create.(params: params, current_user: super_admin_user)
      expect(result).to be_failure
      expect(result[:model]).to_not be_persisted
    end
  end

  context "visibility is visible" do
    let (:visibility) { "visible" }  
    it "is valid" do
      result = Category::Create.(params: params, current_user: super_admin_user)
      expect(result).to be_success
      expect(result[:model]).to be_persisted
      expect(result[:model].name).to eq "News"
      expect(result[:model].description).to eq "Only newest news!"
      expect(result[:model].visibility).to eq "visible"
      expect(result[:model].position).to eq 1
      expect(result["result.policy.default"]).to be_success
    end
  end

  context "visibility is invisible" do
    let (:visibility) { "invisible" }  
    it "is valid" do
      result = Category::Create.(params: params, current_user: super_admin_user)
      expect(result).to be_success
      expect(result[:model]).to be_persisted
      expect(result[:model].name).to eq "News"
      expect(result[:model].description).to eq "Only newest news!"
      expect(result[:model].visibility).to eq "invisible"
      expect(result[:model].position).to eq 1
      expect(result["result.policy.default"]).to be_success
    end
  end
end
