class Admin::SitesController < ApplicationController

  before_action :set_site, only: [:edit, :update]
  before_action :authenticate_admin!

  def edit
  end

  def update
    puts "PPPAARRAAMMSS #{params.inspect}"
    if params[:stylesheet]
      authorize [:admin, :site], :change_stylesheet
      if @site.update(stylesheet_id: params[:stylesheet])
        redirect_back(fallback_location: (request.referer || root_path), notice: "The styleshhet was successfully activated.")
        #redirect_to edit_admin_stylesheet_path(params[:id]), notice: 'The styleshhet was successfully activated.'
      else
        render controller: :stylesheets, action: :edit
      end
    else
      authorize [:admin, @site]
      if @site.update(site_params)
        redirect_to edit_admin_site_path, notice: 'Site was successfully updated.'
      else
        render :edit
      end
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
