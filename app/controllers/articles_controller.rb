class ArticlesController < ApplicationController
  def index
    authorize Article, :index?
    @articles = Article.available
  end

  def new
    authorize Article, :new?
    @article = Article.new
  end

  def create
    authorize Article, :create?
    @article = Article.new(article_params)
    if @article.save
      redirect_to @article
    else
      render 'new'
    end
  end

  def show
    authorize Article, :show?
    @article = Article.find(params[:id])
    @comments = @article.comments.available
  end

  def edit
    authorize Article, :edit?
    @article = Article.find(params[:id])
  end

  def update
    authorize Article, :update?
    @article = Article.find(params[:id])
    if @article.update(article_params)
      redirect_to @article
    else
      render 'edit'
    end
  end

  def destroy
    authorize Article, :destroy?
    @article = Article.find(params[:id])
    @article.update(status: false)
    redirect_to articles_path
  end

  private

  def article_params
    params.require(:article).permit(:title, :text)
  end
end
