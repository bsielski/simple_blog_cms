require "rails_helper"

describe HeaderSection::Cell::Item, type: :cell do
  
  before (:example) do
    @section = HeaderSection.create!(
      position: 1,
      content: "Home Page"
    )
  end
  
  subject { cell(HeaderSection::Cell::Item, @section, root_path: "http://example.org").(:show) }

  it { expect(subject).to have_content "Home Page" }
  it { expect(subject).to have_link("Home Page", :href=>"http://example.org") }

end
