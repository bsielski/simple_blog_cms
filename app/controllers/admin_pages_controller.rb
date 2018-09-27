class AdminPagesController < ApplicationController

  before_action :authenticate_admin!

  def show
    render template: "admin_pages/#{params[:page]}"
  end
end
