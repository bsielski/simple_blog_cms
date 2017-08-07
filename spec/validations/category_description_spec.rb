require 'rails_helper'

RSpec.describe Category, :type => :model do

    it "fails with a description longer than 512 characters" do
      category = Category.new name: "News", description: "A" * 513,
        visibility: 0, position: 1
      expect(category).to be_invalid
    end

    it "is valid with description 512 characters long" do
      category = Category.new name: "News", description: "B" * 512,
      visibility: 0, position: 1
      expect(category).to be_valid
    end

    it "is valid when a description is an empty string" do
      category = Category.new name: "News", description: "",
        visibility: 0, position: 1
      expect(category).to be_valid
    end

    it "fails when a description is nil" do
      category = Category.new name: "News", description: nil,
        visibility: 0, position: 1
      expect(category).to be_invalid
    end

    it "is valid with not unique description" do
      Category.create name: "News", description: "Some generic sescription.", visibility: 0, position: 1
      category = Category.new name: "Sport", description: "Some generic sescription.",
        visibility: 0, position: 1
      expect(category).to be_valid
    end

    it "is stripped and squeeze whitespaces in names before save" do
      Category.create name: "News", description: "\tOnly    \t\t\t the newest   news!!!\n", visibility: 0, position: 1
      expect(Category.last.description).to be == "Only the newest news!!!"
    end


end
