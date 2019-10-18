class ArticlesController < ApplicationController
  def index
    @articles = Article.available
  end

  def new
  end

  def create
    @article = Article.new(article_params)
    @article.save
    redirect_to @article
  end

  def show
    @article = Article.find(params[:id])
  end

  def edit
  end

  def update
  end

  def destroy
    @article = Article.find(params[:id])
    @article.update(status: false)
    redirect_to articles_path
  end

  private

  def article_params
    params.require(:article).permit(:title, :text)
  end
end
