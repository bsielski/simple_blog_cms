require 'rails_helper'

RSpec.describe Category, :type => :model do

    it "is valid when visibility is 0" do
      category = Category.new name: "News", description: "Only the newest news!",
        visibility: 0, position: 1
      expect(category).to be_valid
    end

    it "is valid when visibility is 1" do
      category = Category.new name: "News", description: "Only the newest news!",
        visibility: 1, position: 1
      expect(category).to be_valid
    end

end
