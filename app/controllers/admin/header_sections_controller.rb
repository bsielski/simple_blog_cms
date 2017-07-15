class Admin::HeaderSectionsController < ApplicationController

  before_action :authenticate_admin!
  before_action :set_header_section, only: [:edit, :update, :delete, :destroy]
  before_action :content_to_markdown, only: :edit
  before_action :set_current_header_for_index, only: :index
  before_action :set_current_header_for_show, only: :show
  before_action :set_current_header_for_new, only: :new
  before_action :set_current_header_for_edit, only: :edit
  before_action :set_current_header_for_delete, only: :delete

  def index
    @header_sections = HeaderSection.order(:position).paginate(:page => params[:page], :per_page => 100)
  end

  def new
    @header_section = HeaderSection.new
  end

  def create
    @header_section = HeaderSection.new(header_section_params)
    authorize [:admin, @header_section]
    if @header_section.save
      redirect_to admin_header_sections_path, notice: 'Header section was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    authorize [:admin, @header_section]
    if @header_section.update(header_section_params)
      redirect_to admin_header_sections_path, notice: 'Header section was successfully updated.'
    else
      render :edit
    end

  end

  def delete

  end

  def destroy
    authorize [:admin, @header_section]
    @header_section.destroy
    redirect_to admin_header_sections_path, notice: 'Header section was successfully destroyed.'
  end

  private

  def set_header_section
    @header_section = HeaderSection.find(params[:id])
  end

  def content_to_markdown
    @header_section.convert_content_to_markdown
  end

  def header_section_params
    params.require(:header_section).permit(:position, :content)
  end

  def set_current_header_for_index
    @current_page_header = "Manage header section"
  end

  def set_current_header_for_show
    @current_page_header = "Header Section: #{@header_section.position}"
  end

  def set_current_header_for_new
    @current_page_header = "New header section"
  end

  def set_current_header_for_edit
    @current_page_header = "Edit header section: #{@header_section.position}"
  end

  def set_current_header_for_delete
    @current_page_header = "Delete header section: #{@header_section.position}"
  end

end
