require "rails_helper"

describe HeaderSection::Cell::Container, type: :cell do
  before (:example) do
    @powered = HeaderSection.create!(
      position: 1,
      content: "Home Page"
    )
    @copyright = HeaderSection.create!(
      position: 2,
      content: "Logo"
    )
  end
  
  subject { cell(HeaderSection::Cell::Container, nil, current_admin: nil, root_path: "http://example.org").(:show) }
  it { expect(subject.text).to match(/Home Page.*Logo/m) }
  it { expect(subject).to have_link("Home Page", :href=>"http://example.org") }
  it { expect(subject).to have_link("Logo", :href=>"http://example.org") }

end
