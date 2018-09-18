require "reform"
require "reform/form/dry"

module FooterSection::Contract
  class Create < Reform::Form
    include Dry

    property :content
    property :position
    
    validation do
      configure do
        config.messages_file = File.join(Rails.root, "config", "locales", "en.yml")
      end
      required(:content) { str? }
    end
  end
end
