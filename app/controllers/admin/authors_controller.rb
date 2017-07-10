class Admin::AuthorsController < ApplicationController

  before_action :set_author, only: [:edit, :update, :delete, :destroy]
  before_action :description_to_markdown, only: :edit
  before_action :authenticate_admin!

  def index

    if params[:admin_id]
      @admin = Admin.find(params[:admin_id])
      @header = "My authors"
      @authors = @admin.authors.includes(:admin, :articles)
    else
      @header = "All authors"
      @authors = Author.includes(:admin, :articles)
    end
    @authors = @authors.paginate(:page => params[:page], :per_page => 100)
  end

  def new
    @author = Author.new
  end

  def create
    @author = current_admin.authors.new(author_params)
    authorize [:admin, @author]
    if @author.save
      redirect_to admin_authors_path(@author), notice: 'Author was successfully created.'
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
