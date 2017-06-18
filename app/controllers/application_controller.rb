class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_everything

  private

  def set_everything
    @header_sections = HeaderSection.all
    @footer_sections = FooterSection.all
    @categories = Category.order(:position)
    @current_style = Site.first.stylesheet.content
    @category = Category.default
  end
  
end
