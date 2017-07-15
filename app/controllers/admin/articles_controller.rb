class Admin::ArticlesController < ApplicationController

  before_action :authenticate_admin!
  before_action :set_article, only: [:edit, :update, :delete, :destroy]
  before_action :content_to_markdown, only: :edit
  before_action :check_author, only: [:create]
  before_action :set_current_header_for_index, only: :index
  before_action :set_current_header_for_show, only: :show
  before_action :set_current_header_for_new, only: :new
  before_action :set_current_header_for_edit, only: :edit
  before_action :set_current_header_for_delete, only: :delete

  def index
    if params[:category_id]
      @category = Category.find(params[:category_id].to_i)
      @articles = @category.articles.includes(:author, :categories).reverse_order
    else
      @articles = Article.includes(:author, :categories).reverse_order
    end
    @articles = @articles.paginate(:page => params[:page], :per_page => 100)
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    authorize [:admin, @article]
    if @article.save
      redirect_to edit_admin_article_path(@article), notice: 'Article was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update

    if params[:status]
      authorize [:admin, @article], :change_status?
      if @article.update(status: params[:status])
        redirect_back(fallback_location: (request.referer || root_path), notice: "The article was successfully #{@article.status}.")
      else
        render controller: :articles, action: :edit
      end
    else
      authorize [:admin, @article]
      if @article.update(article_params)
        redirect_to edit_admin_article_path, notice: 'The article was successfully updated.'
      else
        render :edit
      end
    end

  end

  def delete

  end

  def destroy
    authorize [:admin, @article]
    @article.destroy
    redirect_to admin_articles_path, notice: 'Article was successfully destroyed.'
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end

  def check_author
    unless Author.find(article_params[:author_id]).admin == current_admin
      redirect_to admin_articles_path
    end
  end

  def content_to_markdown
    @article.convert_content_to_markdown
  end

  def article_params
    params.require(:article).permit(:title, :content, :published_at, :author_id, category_ids: [])
  end

  def set_current_header_for_index
    @current_page_header = "Manage articles"
  end

  def set_current_header_for_show
    @current_page_header = "#{@article.title}"
  end

  def set_current_header_for_new
    @current_page_header = "New article"
  end

  def set_current_header_for_edit
    @current_page_header = "Edit article: #{@article.title}"
  end

  def set_current_header_for_delete
    @current_page_header = "Delete article: #{@article.title}"
  end

end
