class ApplicationController < ActionController::Base
  include Pundit

  protect_from_forgery with: :exception
  before_action :set_everything

  def pundit_user
    current_admin
  end

  private

  def set_everything
    @header_sections = HeaderSection.order(:position)
    @footer_sections = FooterSection.order(:position)
    @visible_categories = Category.visible.order(:position)
    @current_style = Site.first.stylesheet.content
  end

end
