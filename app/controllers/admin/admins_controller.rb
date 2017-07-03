class Admin::AdminsController < ApplicationController
  
  before_action :set_admin, only: [:edit, :update, :delete, :destroy]
  before_action :authenticate_admin!


  def index
    @admins = Admin.includes(:authors, :roles).paginate(:page => params[:page], :per_page => 100)

  end

  def edit
  end

  def update
    if @admin.update(admin_params)
      redirect_to edit_admin_admin_path, notice: 'Admin was successfully updated.'
    else
      render :edit
    end

  end

  def delete

  end
  
  def destroy
    @admin.destroy
    redirect_to admin_admins_path, notice: 'Admin was successfully destroyed.'
  end

  private

  def set_admin
    @admin = Admin.find(params[:id])
  end
    
  def admin_params
    params.require(:admin).permit(:email)
  end

end
