class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception


  private

  def set_header_and_footer
    @header_sections = HeaderSection.all
    @footer_sections = FooterSection.all
    @categories = Category.order(:position)
  end
  
end
