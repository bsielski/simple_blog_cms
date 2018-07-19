require "reform"
require "reform/form/dry"

module Category::Contract
  class Create < Reform::Form
    include Dry

    property :name
    property :description
    property :visibility
    property :position
    
    validation do
      configure do
        config.messages_file = File.join(Rails.root, "config", "locales", "en.yml")
        def unique_name?(value)
          Category.find_by(name: value).nil?
        end
      end
      required(:visibility) { eql?("invisible") | eql?("visible") }
      required(:name) { filled? & max_size?(56) & unique_name? }
      required(:description) { str? & max_size?(512) }
    end
  end
end
