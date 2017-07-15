class AdminPagesController < ApplicationController

  before_action :authenticate_admin!
  before_action :set_current_header_for_show, only: :show

  def show
    render template: "admin_pages/#{params[:page]}"
  end

  private

  def set_current_header_for_show
    if params[:page] == "home"
      @current_page_header = "Admin panel"
    end
  end

end
