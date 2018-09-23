require "rails_helper"

describe VersionNumber::Cell::Item, type: :cell do
  
  let (:number) { "#{major}.#{minor}.#{patch}" }
  let (:major) { Random.new.rand(0..9) }
  let (:minor) { Random.new.rand(0..99) }
  let (:patch) { Random.new.rand(0..99) }
          
  subject { cell(VersionNumber::Cell::Item, nil, number: number).(:show) }

  it { expect(subject).to have_content number }
end
