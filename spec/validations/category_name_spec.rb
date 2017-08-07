require 'rails_helper'

RSpec.describe Category, :type => :model do

    it 'is valid when every field is OK' do
      category = Category.new name: "News", description: "Only the newest news!",
      visibility: 0, position: 1
      expect(category).to be_valid
    end

    it "fails with a name longer than 56 characters" do
      category = Category.new name: "a" * 57, description: "Only the newest news!",
        visibility: 0, position: 1
      expect(category).to be_invalid
    end

    it "is valid when it's name is 56 characters" do
      category = Category.new name: "b" * 56, description: "Only the newest news!",
      visibility: 0, position: 1
      expect(category).to be_valid
    end

    it "fails with a name is empty string" do
      category = Category.new name: "", description: "Only the newest news!",
        visibility: 0, position: 1
      expect(category).to be_invalid
    end

    it "fails with a name is nil" do
      category = Category.new name: nil, description: "Only the newest news!",
        visibility: 0, position: 1
      expect(category).to be_invalid
    end

    it "fails with a name is only a space character" do
      category = Category.new name: " ", description: "Only the newest news!",
        visibility: 0, position: 1
      expect(category).to be_invalid
    end

    it "fails with a name is only a new line character" do
      category = Category.new name: "\n", description: "Only the newest news!",
        visibility: 0, position: 1
      expect(category).to be_invalid
    end

    it "fails with a name is a mix of spaces and new lines characters" do
      category = Category.new name: " \n \n\n  \n", description: "Only the newest news!",
        visibility: 0, position: 1
      expect(category).to be_invalid
    end

    it "fails with not unique name" do
      Category.create name: "I am the first!", description: "The first category.", visibility: 0, position: 1
      category = Category.new name: "I am the first!", description: "I hope my name is unique.",
        visibility: 0, position: 1
      expect(category).to be_invalid
    end

    it "is stripped and squeeze whitespaces in names before save" do
      Category.create name: " I am the  \t\t \t first!!! \n ", description: "The first category.", visibility: 0, position: 1
      expect(Category.last.name).to be == "I am the first!!!"
    end

    it "fails when the name differs with just whitespaces" do
      Category.create name: " I am the  \t\n\t \t first!!! \n ", description: "The first category.", visibility: 0, position: 1
      category = Category.new name: "\t\t\t\t\tI      am\t\t\t\tthe\n\n\n\n\nfirst!!!\t \n", description: "I hope my name is unique.",
        visibility: 0, position: 1
      expect(category).to be_invalid
    end


end
