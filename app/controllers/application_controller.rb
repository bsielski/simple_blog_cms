class ApplicationController < ActionController::Base
  include Pundit

  protect_from_forgery with: :exception
  before_action :set_everything

  def pundit_user
    current_admin
  end

  private

  def _run_options(options)
    options.merge( current_user: current_admin )
  end

  def set_everything
    @current_style = Site.first.stylesheet.content
  end
end
