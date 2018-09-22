require "rails_helper"

describe FooterSection::Cell::Form, type: :cell do

  controller Admin::FooterSectionsController
  
  let (:result) {
    FooterSection::Create::Present.(params: {})
  }  
  let (:model) {
    result[:model]
  }
  let (:errors) {
    form.errors
  }
  let (:form) {
    result["contract.default"]
  }

  subject { cell(FooterSection::Cell::Form, model, errors: errors).(:show) }

  it { expect(subject).to have_button "Save" }
  it { expect(subject).to have_select("Position") }  
  it { expect(subject).to have_field("Content", type: "textarea") }
end
