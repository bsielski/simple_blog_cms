class Admin::CategoriesController < ApplicationController

  before_action :set_category, only: [:edit, :update, :delete, :destroy]
  before_action :authenticate_admin!

  def index
    @categories = Category.order :position
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    authorize [:admin, @category]
    if @category.save
      redirect_to edit_admin_category_path(@category), notice: 'Category was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    authorize [:admin, @category]
    if @category.update(category_params)
      redirect_to edit_admin_category_path(@category), notice: 'Category was successfully updated.'
    else
      render :edit
    end

  end

  def delete

  end

  def destroy
    authorize [:admin, @category]
    @category.destroy
    redirect_to admin_categories_path, notice: 'Category was successfully destroyed.'
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name, :privacy, :description, :position)
  end

end
