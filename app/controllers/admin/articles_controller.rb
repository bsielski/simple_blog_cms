class Admin::ArticlesController < ApplicationController

  before_action :set_article, only: [:edit, :update, :delete, :destroy]
  before_action :content_to_markdown, only: :edit
  before_action :authenticate_admin!

  before_action :check_author, only: [:create]

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
    authorize [:admin, @article]
    if @article.update(article_edit_params)
      redirect_to edit_admin_article_path, notice: 'Article was successfully updated.'
    else
      render :edit
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
    params.require(:article).permit(:title, :status, :content, :author_id, category_ids: [])
  end

  def article_edit_params
    params.require(:article).permit(:title, :status, :content, :published_at, :author_id, category_ids: [])
  end

end
