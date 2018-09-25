require "rails_helper"

describe FooterSection::Cell::Delete, type: :cell do
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
  let (:result) { FooterSection::Destroy::Present.(params: params) }
  let (:params) { { id: id } }
  let (:model) { result[:model] }
  let (:policy) { double("Policy") }

  subject { cell(FooterSection::Cell::Delete, model, policy: policy).(:show) }

  it { expect(subject).to have_content "Delete footer section: 1" }
  it { expect(subject).to have_content "Are you sure? The content of deleting section is:" }
  it { expect(subject).to have_content "Powered by Simple Blog CMS (beta)" }
  it { expect(subject).to have_link("Delete", href: /admin\/footer_sections\/#{id}/) }
  it { expect(subject).to have_link("Back", href: /admin\/footer_sections/) }
end
