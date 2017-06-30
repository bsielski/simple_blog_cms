class ArticlesController < ApplicationController

  before_action :set_article, only: [:show]

  def index
    if params[:category_id]
      @category = Category.find(params[:category_id])
      @visible_articles = @category.articles.includes(:author, :categories).visible.reverse_order
    elsif params[:author_id]
      @author = Author.find(params[:author_id])
      @visible_articles = @author.articles.includes(:author, :categories).visible.reverse_order 
    else
      @visible_articles = Article.includes(:author, :categories).visible.reverse_order
    end
    @visible_articles = @visible_articles.paginate(:page => params[:page], :per_page => 10)

  end


  def show

  end

  private
  
  def set_article
    @article = Article.find(params[:id])
  end
    
end
