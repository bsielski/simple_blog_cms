require "rails_helper"

describe FooterSection::Cell::New, type: :cell do

  controller Admin::FooterSectionsController

  let (:result) {
    FooterSection::Create::Present.(params: {})
  }
  
  let (:model) {
    result[:model]
  }

  let (:form) {
    result["contract.default"]
  }
  
  subject { cell(FooterSection::Cell::New, model, form: form).(:show) }

  it { expect(subject).to have_content "New footer section" }
  it { expect(subject).to have_button "Save" }
  it { expect(subject).to have_select("Position") }  
  it { expect(subject).to have_field("Content", type: "textarea") }
  it { expect(subject).to have_link("Back") }
end
