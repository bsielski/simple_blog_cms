class ArticlesController < ApplicationController
  def index
    if params[:category_id]
      @category = Category.find(params[:category_id].to_i)
      @visible_articles = @category.articles.visible
 
    else
      @visible_articles = Article.visible
    end
    @visible_articles = @visible_articles.paginate(:page => params[:page], :per_page => 10)

  end
  
end
