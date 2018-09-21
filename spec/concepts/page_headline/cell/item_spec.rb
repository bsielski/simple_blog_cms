require "rails_helper"

describe PageHeadline::Cell::Item, type: :cell do
  
  subject {
    cell(described_class, nil, text: text).(:show)
  }
  
  let (:text) { "The Title" }
  
  it "generates header with injected text" do
    expect(subject).to have_content "The Title"
  end
end
