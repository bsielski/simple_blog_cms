class Admin::AdminsController < ApplicationController

  before_action :authenticate_admin!
  before_action :set_admin, only: [:edit, :update, :delete, :destroy]

  def index
    @admins = Admin.includes(:authors, :roles).paginate(:page => params[:page], :per_page => 100)
  end

  def edit

  end

  def update
    @change = ChangingRoles.new(@admin.roles, params[:admin][:role_ids])
    if params[:admin] and params[:admin][:email]
      authorize [:admin, @admin], :change_email?
    end
    if params[:admin][:role_ids]
      authorize [:admin, @admin], :dont_want_to_change_his_own_roles?
      authorize @change, :change_roles?
    end
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
    params.require(:admin).permit(:email, role_ids: [])
  end
end
