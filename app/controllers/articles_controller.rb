class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit,:update, :destroy]
  def show
  end

  def index
    @articles = Article.all
  end

  def new
    @article = Article.new
  end

  def edit
  end

  def create
    @article = Article.new(do_whitelisting)
    @article.user = User.first
    if @article.save
      flash[:notice] = "Articles got saved successfully"
      redirect_to article_path(@article)
    else
      render 'new'
    end
  end

  def update
    if @article.update(do_whitelisting)
      flash[:notice] = "Article got updated successfully"
      redirect_to article_path(@article)
    else
      flash[:notice] = "Failed to update the article"
      render 'edit'
    end
  end

  def destroy
    if @article.destroy
      flash[:notice] = "Article deleted successfully"
      redirect_to articles_path
    else 
      flash[:notice] = "Failed to delete article"
      render 'delete'
    end
  end

  private

  def do_whitelisting
    params.require(:article).permit(:title, :description)
  end

  def set_article
    @article = Article.find(params[:id])
  end
end
