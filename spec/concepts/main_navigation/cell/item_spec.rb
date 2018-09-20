require "rails_helper"

describe MainNavigation::Cell::Item, type: :cell do
  
  before (:example) do
    @category= Category.create!(name: name, description: description, visibility: visibility, position: position)
  end
  let (:name) { "News" }
  let (:description) { "Only newest news!" }
  let (:visibility) { "invisible" }
  let (:position) { 1 }
  
  subject { cell(MainNavigation::Cell::Item, @category, current_category_id: nil).(:show) }

  it { expect(subject).to have_content "News" }
end
