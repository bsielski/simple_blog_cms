require "rails_helper"

describe FooterSection::Cell::Container, type: :cell do
  before (:example) do
    @powered = FooterSection.create!(
      position: 1,
      content: "Powered by Simple Blog CMS"
    )
    @copyright = FooterSection.create!(
      position: 2,
      content: "Copyright 2018"
    )
  end
  
  subject { cell(FooterSection::Cell::Container, nil, current_admin: nil).(:show) }
  it { expect(subject.text).to match(/Powered by Simple Blog CMS.*Copyright 2018/m) }
end
