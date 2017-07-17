class ArticlesController < ApplicationController

  before_action :set_article, only: [:show]
  before_action :set_articles, only: [:index]
  before_action :set_current_header_for_index, only: :index
  before_action :set_current_header_for_show, only: :show

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

  def set_current_header_for_index
    if params[:category_id]
      @current_page_header = @category.name
    elsif params[:author_id]
      @current_page_header = "Articles by #{@author.name}"
    else
      @current_page_header = "All articles"
    end
  end

  def set_current_header_for_show
    @current_page_header = "#{@article.title}"
  end

end
