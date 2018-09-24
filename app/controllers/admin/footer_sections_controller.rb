class Admin::FooterSectionsController < ApplicationController

  def index
    run FooterSection::Index
    render cell(FooterSection::Cell::Index, @model, policy: FooterSectionPolicy.new(current_admin, @model))
  end

  def new
    run FooterSection::Create::Present
    render cell(FooterSection::Cell::New, @model, form: @form)
  end

  def create
    create_op = run FooterSection::Create do
      return redirect_to admin_footer_sections_path
    end
    render cell(FooterSection::Cell::Edit, @model, form: @form, policy: FooterSectionPolicy.new(current_admin, @model))
  end

  def edit
    update_op = run FooterSection::Update::Present
    render cell(FooterSection::Cell::Edit, @model, form: @form, policy: FooterSectionPolicy.new(current_admin, @model))
  end

  def update
    update_op = run FooterSection::Update do
      return redirect_to admin_footer_sections_path
    end
    render cell(FooterSection::Cell::Edit, @model, form: @form, policy: FooterSectionPolicy.new(current_admin, @model))
  end

  def delete
    run FooterSection::Destroy::Present
    render cell(FooterSection::Cell::Delete, @model, policy: FooterSectionPolicy.new(current_admin, @model))

  end

  def destroy
    run FooterSection::Destroy do
      return redirect_to admin_footer_sections_path
    end
    render cell(FooterSection::Cell::Delete, @model, policy: FooterSectionPolicy.new(current_admin, @model))
  end
end
