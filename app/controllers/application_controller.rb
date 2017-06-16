class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_header_and_footer

  private

  def set_header_and_footer
    @header_sections = HeaderSection.all
    @footer_sections = FooterSection.all
    @categories = Category.order(:position)
    @current_style = Site.first.stylesheet.content
  end
  
end
