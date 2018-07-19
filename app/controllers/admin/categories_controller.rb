class Admin::CategoriesController < ApplicationController

  before_action :authenticate_admin!
  before_action :set_category, only: [:edit, :update, :delete, :destroy]
  before_action :set_current_header_for_index, only: :index
  before_action :set_current_header_for_show, only: :show
  before_action :set_current_header_for_new, only: :new
  before_action :set_current_header_for_edit, only: :edit
  before_action :set_current_header_for_delete, only: :delete

  def index
    @categories = Category.order :position
  end

  def new
    # short way
    # run Category::Create::Present

    # long way
    result = Category::Create::Present.(params: params, current_user: current_admin)
    #@form = result["contract.default"]
    @model = result[:model]
  end

  def create
    result = Category::Create.(params: params, current_user: current_admin)
    #@form = result["contract.default"]
    @model = result[:model]
    if result.success?
      redirect_to edit_admin_category_path(@model), notice: 'Category was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    authorize [:admin, @model]
    if @model.update(category_params)
      redirect_to edit_admin_category_path(@model), notice: 'Category was successfully updated.'
    else
      render :edit
    end

  end

  def delete

  end

  def destroy
    authorize [:admin, @model]
    @model.destroy
    redirect_to admin_categories_path, notice: 'Category was successfully destroyed.'
  end

  private

  def set_category
    @model = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name, :visibility, :description, :position)
  end

  def set_current_header_for_index
    @current_page_header = "Manage categories"
  end

  def set_current_header_for_show
    @current_page_header = "Category: #{@model.name}"
  end

  def set_current_header_for_new
    @current_page_header = "New category"
  end

  def set_current_header_for_edit
    @current_page_header = "Edit category: #{@model.name}"
  end

  def set_current_header_for_delete
    @current_page_header = "Delete category: #{@model.name}"
  end

end
