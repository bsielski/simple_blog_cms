class Admin::SitesController < ApplicationController

  before_action :set_site, only: [:edit, :update]
  before_action :authenticate_admin!

  def edit
  end

  def update
    if @site.update(site_params)
      redirect_to edit_admin_site_path, notice: 'Site was successfully updated.'
    else
      render :edit
    end

  end
  
  private

  def set_site
    @site = Site.first
  end
    
  def site_params
    params.require(:site).permit(:title, :author, :keywords, :description)
  end

end
