class ApplicationController < ActionController::Base
  include Pundit

  protect_from_forgery with: :exception

  def pundit_user
    current_admin
  end

  private

  def _run_options(options)
    options.merge( current_user: current_admin )
  end

end
