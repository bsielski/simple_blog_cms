class ArticlesController < ApplicationController

  before_action :set_article, only: [:show]
  before_action :set_articles, only: [:index]

  def index
    @published_articles = @published_articles.published.order(:published_at).reverse_order.paginate(:page => params[:page], :per_page => 10)
  end

  def show
    authorize @article
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end

  def set_articles
    if params[:category_id]
      @category = Category.find(params[:category_id])
      @published_articles = @category.articles.includes(:author, :categories)
    elsif params[:author_id]
      @author = Author.find(params[:author_id])
      @published_articles = @author.articles.includes(:author, :categories)
    else
      @published_articles = Article.from_visible_category.includes(:author, :categories)
    end
  end
end
