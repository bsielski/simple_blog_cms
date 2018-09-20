require "rails_helper"

describe FooterSection::Cell::Item, type: :cell do
  
  before (:example) do
    @section = FooterSection.create!(
      position: 1,
      content: "<div>Powered by Simple Blog CMS</div>"
    )
  end
  
  subject { cell(FooterSection::Cell::Item, @section).(:show) }

  it { expect(subject).to have_content "Powered by Simple Blog CMS" }
end
