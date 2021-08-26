class ArticlesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :destroy]
  before_action :move_set, except: [:index, :new, :create, :show, :destroy, :update]
  before_action :move_to_index, except: [:index, :new, :create, :show, :destroy, :update]

  def index
    @articles = Article.order("created_at DESC")
  end

  def new
    @article = Article.new
  end

  def create
    
    @article = Article.new(article_params)
    if @article.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @article = Article.find(params[:id])
  end

  def edit
  end

  def update
    article = Article.find(params[:id])
    if Article.update(article_params)
      redirect_to article_path
    else
      redirect_to action: :edit
    end
  end

  def destroy
    article = Article.find(params[:id])
    article.destroy
    redirect_to root_path
  end

  private
  def article_params
    params.require(:article).permit(:image, :country, :city, :season, :english_id, :safe_id, :nice_id, :content).merge(user_id: current_user.id)
  end

  def move_set
    @article = Article.find(params[:id])
  end

  def move_to_index
    unless current_user == @article.user
      redirect_to action: :index
    end
  end
end
