class Admin::AuthorsController < ApplicationController

  before_action :authenticate_admin!
  before_action :set_author, only: [:edit, :update, :delete, :destroy]
  before_action :description_to_markdown, only: :edit

  def index
    @authors = policy_scope([:admin, Author]).includes(:admin, :articles)
    @authors = @authors.paginate(:page => params[:page], :per_page => 100)
  end

  def new
    @author = Author.new
  end

  def create
    @author = Author.new(author_params)
    authorize [:admin, @author]
    if @author.save
      redirect_to admin_authors_path, notice: 'Author was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    authorize [:admin, @author]
    if @author.update(author_params)
      redirect_to admin_authors_path, notice: 'Author was successfully updated.'
    else
      render :edit
    end

  end

  def delete
  end

  def destroy
    authorize [:admin, @author]
    @author.destroy
    redirect_to admin_authors_path, notice: 'Author was successfully destroyed.'
  end

  private

  def set_author
    @author = Author.find(params[:id])
  end

  def description_to_markdown
    @author.convert_description_to_markdown
  end

  def author_params
    params.require(:author).permit(:name, :description, :admin_id)
  end
end
