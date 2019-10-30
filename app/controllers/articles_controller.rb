class ArticlesController < ApplicationController
  before_action :find_article, only: [:edit, :update, :show, :delete]

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
      flash[:notice] = "Successfully created article!"
      redirect_to @article
    else
      flash[:alert] = "Error creating new post!"
      render 'new'
    end
  end

  def show
    authorize Article, :show?
    @comments = @article.comments.available
  end

  def edit
    authorize Article, :edit?
  end

  def update
    authorize Article, :update?
    if @article.update(article_params)
      flash[:notice] = "Successfully updated article!"
      redirect_to @article
    else
      flash[:alert] = "Error updating article!"
      render 'edit'
    end
  end

  def destroy
    authorize Article, :destroy?
    if @article.update(status: false)
      flash[:notice] = "Successfully deleted post!"
    else
      flash[:alert] = "Error deleting post!"
    end
    redirect_to articles_path
  end

  private

  def article_params
    params.require(:article).permit(:title, :text)
  end

  def find_article
    @article = Article.find(params[:id])
  end
end
