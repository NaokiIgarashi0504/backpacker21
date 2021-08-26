class ArticlesController < ApplicationController
  def index
    @articles = Article.order("created_at DESC")
  end

  def new
    @article = Article.new
  end

  def create
    Article.create(article_params)
  end

  private
  def article_params
    params.require(:article).permit(:image, :country, :city, :season, :english_id, :safe_id, :nice_id, :content)
  end

end
