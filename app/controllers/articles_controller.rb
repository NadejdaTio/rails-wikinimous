class ArticlesController < ApplicationController
  before_action :find_article, only: [:show, :edit, :destroy, :update]

  def index
    @articles = Article.all
  end

  def show
    @title = Kramdown::Document.new("###{@article.title}##").to_html
    @content = Kramdown::Document.new("####{@article.content}###").to_html
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    @article.save
    if @article.save
      redirect_to article_path(@article)
    else
      fail
    end
  end

  def edit
  end

  def update
    @article.update(article_params)
    redirect_to article_path(@article)
  end

  def destroy
    @article.destroy
    redirect_to articles_path
  end

  private

  def find_article
    @article = Article.find(params[:id])
  end

  def article_params
    # *Strong params*: You need to *whitelist* what
    # can be updated by the user
    # Never trust user data!
    params.require(:article).permit(:title, :content)
  end
end
