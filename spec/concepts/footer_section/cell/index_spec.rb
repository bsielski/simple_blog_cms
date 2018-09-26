require "rails_helper"

describe FooterSection::Cell::Delete, type: :cell do
  controller Admin::FooterSectionsController

  subject { cell(FooterSection::Cell::Index, model, policy: policy).(:show) }

  let! (:footer_sections) do
    FooterSection.create!(
      position: 1,
      content: Convert.to_html("Powered by")
    )
    FooterSection.create!(
      position: 2,
      content: Convert.to_html("Simple Blog CMS (beta)")
    )
  end
  let (:ids) { FooterSection.pluck(:id) }
  let (:result) { FooterSection::Index.(params: params) }
  let (:params) { {} }
  let (:model) { result[:model] }
  let (:policy) { double("Policy") }
  let (:can_create) { true }
  let (:can_update) { true }
  let (:can_destroy) { true }

  before do
    allow(policy)
      .to receive(:create?).and_return(can_create)
    allow(policy)
      .to receive(:update?).and_return(can_update)
    allow(policy)
      .to receive(:destroy?).and_return(can_destroy)
  end

  RSpec.shared_examples "displays basic elements" do
    it { expect(subject).to have_content "Id" }
    it { expect(subject).to have_content "Position" }
    it { expect(subject).to have_content "Contains" }
    it { expect(subject).to have_content "#{ids[0]}" }
    it { expect(subject).to have_content "1" }
    it { expect(subject).to have_content "Powered by\n\n" }
    it { expect(subject).to have_content "#{ids[1]}" }
    it { expect(subject).to have_content "2" }
    it { expect(subject).to have_content "Simple Blog CMS (beta)\n\n" }
  end

  include_examples "displays basic elements"
  it { expect(subject)
         .to have_link("Create a new footer section", href: /admin\/footer_sections\/new$/) }
  it { expect(subject).to have_link("Edit", href: /admin\/footer_sections\/#{ids[0]}\/edit/) }
  it { expect(subject).to have_link("Delete", href: /admin\/footer_sections\/#{ids[0]}\/delete/) }
  it { expect(subject).to have_link("Edit", href: /admin\/footer_sections\/#{ids[1]}\/edit/) }
  it { expect(subject).to have_link("Delete", href: /admin\/footer_sections\/#{ids[1]}\/delete/) }

  context "can not create" do
    let (:can_create) { false }
    include_examples "displays basic elements"
    it { expect(subject).to_not have_link("Create a new footer section") }
    it { expect(subject).to have_link("Edit", href: /admin\/footer_sections\/#{ids[0]}\/edit/) }
    it { expect(subject).to have_link("Delete", href: /admin\/footer_sections\/#{ids[0]}\/delete/) }
    it { expect(subject).to have_link("Edit", href: /admin\/footer_sections\/#{ids[1]}\/edit/) }
    it { expect(subject).to have_link("Delete", href: /admin\/footer_sections\/#{ids[1]}\/delete/) }
  end

  context "can not update" do
    let (:can_update) { false }
    include_examples "displays basic elements"
    it { expect(subject)
           .to have_link("Create a new footer section", href: /admin\/footer_sections\/new$/) }
    it { expect(subject).to_not have_link("Edit") }
    it { expect(subject).to have_link("Delete", href: /admin\/footer_sections\/#{ids[0]}\/delete/) }
    it { expect(subject).to have_link("Delete", href: /admin\/footer_sections\/#{ids[1]}\/delete/) }
  end

  context "can not destroy" do
    let (:can_destroy) { false }
    include_examples "displays basic elements"
    it { expect(subject)
           .to have_link("Create a new footer section", href: /admin\/footer_sections\/new$/) }
    it { expect(subject).to have_link("Edit", href: /admin\/footer_sections\/#{ids[0]}\/edit/) }
    it { expect(subject).to have_link("Edit", href: /admin\/footer_sections\/#{ids[1]}\/edit/) }
    it { expect(subject).to_not have_link("Delete") }
  end
end
