require "rails_helper"

describe "Version number" do

  subject (:version_number) { SimpleSiteCms::Application::VERSION }

  it { expect(version_number).to_not be_nil }
  it { expect(version_number).to match /\d+\.\d+\.\d+/ }
end
