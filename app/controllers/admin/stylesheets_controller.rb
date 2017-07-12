class Admin::StylesheetsController < ApplicationController

  before_action :set_stylesheet, only: [:show, :edit, :update, :delete, :destroy, :activate]
  before_action :authenticate_admin!

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

end
