class Admin::StylesheetsController < ApplicationController
  
  before_action :set_stylesheet, only: [:edit, :update, :delete, :destroy]
  before_action :authenticate_admin!

  def index
    @stylesheets = Stylesheet.paginate(:page => params[:page], :per_page => 100)
  end
  
  def new
    @stylesheet = Stylesheet.new
  end

  def create
    @stylesheet = Stylesheet.new(stylesheet_params)
    if @stylesheet.save
      redirect_to edit_admin_stylesheet_path(@stylesheet), notice: 'Stylesheet was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @stylesheet.update(stylesheet_params)
      redirect_to edit_admin_stylesheet_path, notice: 'Stylesheet was successfully updated.'
    else
      render :edit
    end

  end

  def delete

  end
  
  def destroy
    @stylesheet.destroy
    redirect_to admin_stylesheets_path, notice: 'Stylesheet was successfully destroyed.'
  end
  
  private

  def set_stylesheet
    @stylesheet = Stylesheet.find(params[:id])
  end
    
  def stylesheet_params
    params.require(:stylesheet).permit(:content)
  end

end