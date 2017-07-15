class AuthorsController < ApplicationController

  before_action :set_author, only: [:show]
  before_action :set_current_header_for_show, only: :show

  def index
  end

  def show
  end

  private

  def set_author
    @author = Author.find(params[:id])
  end

  def set_current_header_for_show
    @current_page_header = "#{@author.name}"
  end

end
