class Admin::StylesheetsController < ApplicationController

  before_action :authenticate_admin!
  before_action :set_stylesheet, only: [:show, :edit, :update, :delete, :destroy, :activate]
  before_action :set_current_header_for_index, only: :index
  before_action :set_current_header_for_show, only: :show
  before_action :set_current_header_for_new, only: :new
  before_action :set_current_header_for_edit, only: :edit
  before_action :set_current_header_for_delete, only: :delete

  def index
    @stylesheets = Stylesheet.paginate(:page => params[:page], :per_page => 100)
  end

  def show

  end

  def new
    @stylesheet = Stylesheet.new
  end

  def create
    @stylesheet = Stylesheet.new(stylesheet_params)
    authorize [:admin, @stylesheet]
    if @stylesheet.save
      redirect_to edit_admin_stylesheet_path(@stylesheet), notice: 'Stylesheet was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    authorize [:admin, @stylesheet]
    if @stylesheet.update(stylesheet_params)
      if params[:commit] == 'Save and make active'
        @stylesheet.activate
      end
      redirect_to edit_admin_stylesheet_path, notice: 'Stylesheet was successfully updated.'
    else
      render :edit
    end

  end

  def delete

  end

  def destroy
    authorize [:admin, @stylesheet]
    @stylesheet.destroy
    redirect_to admin_stylesheets_path, notice: 'Stylesheet was successfully destroyed.'
  end

  private

  def set_stylesheet
    @stylesheet = Stylesheet.find(params[:id])
  end

  def stylesheet_params
    params.require(:stylesheet).permit(:name, :content)
  end

  def set_current_header_for_index
    @current_page_header = "Manage stylesheets"
  end

  def set_current_header_for_show
    @current_page_header = "Stylesheet: #{@stylesheet.name}"
  end

  def set_current_header_for_new
    @current_page_header = "New stylesheet"
  end

  def set_current_header_for_edit
    @current_page_header = "Edit stylesheet: #{@stylesheet.name}"
  end

  def set_current_header_for_delete
    @current_page_header = "Delete stylesheet: #{@stylesheet.name}"
  end


end
