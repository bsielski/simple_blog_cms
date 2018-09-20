require "rails_helper"

describe MainNavigation::Cell::Container, type: :cell do
  before (:example) do
    @news = Category.create!(name: "News", description: "Only newest news!", visibility: :visible, position: 1)
    @unfinished = Category.create!(name: "Unfinished", description: "Placeholder", visibility: :invisible, position: 2)
    @blog = Category.create!(name: "Blog", description: "Posts about this blog", visibility: :visible, position: 3)
  end
  
  subject { cell(MainNavigation::Cell::Container, nil, url: nil).(:show) }

  it { expect(subject).to have_content "News" }
  it { expect(subject).to_not have_content "Unfinished" }
  it { expect(subject).to have_content "Blog" }
  it { expect(subject).to have_no_css('.main_navigation__link--active') }

  context "the first link is active" do
    subject { cell(MainNavigation::Cell::Container, nil, url: link).(:show) }
    let (:link) {
      id = @news.id
      "http://example.com/categories/#{id}/articles"
    }

    it "has the first link active" do
      expect(subject).to have_selector('.main_navigation__link--active', text: "News")
    end
    it { expect(subject).to have_no_selector('.main_navigation__link--active', text: "Blog") }
    it { expect(subject).to have_no_selector('.main_navigation__link', text: "Unfinished") }
  end
end
