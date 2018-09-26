require "rails_helper"

describe FooterSection::Cell::Edit, type: :cell do
  controller Admin::FooterSectionsController

  let (:footer_section) do
    FooterSection.create!(
      position: 1,
      content: Convert.to_html("Powered by Simple Blog CMS (beta)")
    )
  end
  let (:id) do
    footer_section.id
  end
  let (:result) { FooterSection::Update::Present.(params: params) }
  let (:params) { { id: id } }
  let (:model) { result[:model] }
  let (:form) { result["contract.default"] }  
  let (:policy) { double("Policy") }
  let (:can_destroy) { true }
  before do
    allow(policy)
      .to receive(:destroy?).and_return(can_destroy)
  end
  subject { cell(FooterSection::Cell::Edit, model, form: form, policy: policy).(:show) }

  it { expect(subject).to have_content "Edit footer section: 1" }
  it { expect(subject).to have_select("Position", selected: '1') }  
  it { expect(subject).to have_field("Content", type: "textarea", with: "Powered by Simple Blog CMS (beta)\n\n") }
  it { expect(subject).to have_button "Save" }
  it { expect(subject).to have_link("Delete", href: /admin\/footer_sections\/#{id}/) }
  it { expect(subject).to have_link("Back", href: /admin\/footer_sections/) }

  context "not allowed to destroy" do
    let (:can_destroy) { false }
    it { expect(subject).to_not have_link("Delete") }
  end
end
