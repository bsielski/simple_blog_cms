class Admin::FooterSectionsController < ApplicationController
  
  before_action :set_footer_section, only: [:edit, :update, :delete, :destroy]
  before_action :content_to_markdown, only: :edit
  before_action :authenticate_admin!

  def index
    @footer_sections = FooterSection.order(:position).paginate(:page => params[:page], :per_page => 100)
  end
  
  def new
    @footer_section = FooterSection.new
  end

  def create
    @footer_section = FooterSection.new(footer_section_params)
    if @footer_section.save
      redirect_to admin_footer_sections_path, notice: 'Footer section was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @footer_section.update(footer_section_params)
      redirect_to admin_footer_sections_path, notice: 'Footer section was successfully updated.'
    else
      render :edit
    end

  end

  def delete

  end
  
  def destroy
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

end
