class Admin::AuthorsController < ApplicationController
  
  before_action :set_author, only: [:edit, :update, :delete, :destroy]
  before_action :authenticate_admin!
  
  def index
    @authors = Author.includes(:admin, :articles).paginate(:page => params[:page], :per_page => 100)
  end
  
  def new
    @author = Author.new
  end

  def create
    @author = current_admin.authors.new(author_params)
    if @author.save
      redirect_to admin_authors_path(@author), notice: 'Author was successfully created.'
    else
      render :new
    end
  end

  def update
    if @author.update(author_params)
      redirect_to admin_authors_path, notice: 'Author was successfully updated.'
    else
      render :edit
    end

  end

  def delete
  end
  
  def destroy
    @author.destroy
    redirect_to admin_authors_path, notice: 'Author was successfully destroyed.'
  end

  private

  def set_author
    @author = Author.find(params[:id])
  end

  def author_params
    params.require(:author).permit(:name, :admin_id)
  end
  
end
