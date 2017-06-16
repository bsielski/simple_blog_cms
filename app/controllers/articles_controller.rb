class ArticlesController < ApplicationController
  def index
    if params[:category_id]
      @category = Category.find(params[:category_id].to_i)
      @articles = @category.articles
 
    else
      @articles = Article.all
    end
    
  end
  
end
