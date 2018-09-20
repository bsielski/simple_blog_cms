class Admin::FooterSectionsController < ApplicationController

  before_action :authenticate_admin!
  before_action :set_footer_section, only: [:delete, :destroy]
  before_action :set_current_header_for_index, only: :index
  before_action :set_current_header_for_show, only: :show
  before_action :set_current_header_for_new, only: :new
  before_action :set_current_header_for_delete, only: :delete

  def index
    run FooterSection::Index
  end

  def new
    run FooterSection::Create::Present
    render cell(FooterSection::Cell::New, @model, form: @form)
  end

  def create
    create_op = run FooterSection::Create do
      return redirect_to admin_footer_sections_path
    end
    render cell(FooterSection::Cell::New, @model, form: @form, policy: FooterSectionPolicy.new(current_admin, @model))
  end

  def edit
    update_op = run FooterSection::Update::Present
    @current_page_header = "Edit footer section: #{@model.position}"
    render cell(FooterSection::Cell::New, @model, form: @form, policy: FooterSectionPolicy.new(current_admin, @model))
  end

  def update
    update_op = run FooterSection::Update do
      return redirect_to admin_footer_sections_path
    end
    render cell(FooterSection::Cell::New, @model, form: @form, policy: FooterSectionPolicy.new(current_admin, @model))
  end

  def delete

  end

  def destroy
    authorize [:admin, @footer_section]
    @footer_section.destroy
    redirect_to admin_footer_sections_path, notice: 'Footer section was successfully destroyed.'
  end

  private

  def set_footer_section
    @footer_section = FooterSection.find(params[:id])
  end

  def content_to_markdown
    @footer_section.convert_content_to_markdown
  end

  def footer_section_params
    params.require(:footer_section).permit(:position, :content)
  end

  def set_current_header_for_index
    @current_page_header = "Manage footer section"
  end

  def set_current_header_for_show
    @current_page_header = "Footer Section: #{@footer_section.position}"
  end

  def set_current_header_for_new
    @current_page_header = "New footer section"
  end

  def set_current_header_for_edit
    @current_page_header = "Edit footer section: #{@model.position}"
  end

  def set_current_header_for_delete
    @current_page_header = "Delete footer section: #{@footer_section.position}"
  end
end
