class ArticlesController < ApplicationController
  def index
    @articles = Article.order("created_at DESC")
  end

  def new
    @articles = Article.all
  end
end
