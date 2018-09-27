module FooterSection::Cell
  class Form < Trailblazer::Cell
    include ActionView::RecordIdentifier
    include ActionView::Helpers::FormOptionsHelper

    def errors
      options[:errors]
    end

    def content_errors
      errors[:content].first
    end
  end
end
