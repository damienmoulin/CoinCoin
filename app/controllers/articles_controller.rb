class ArticlesController < ApplicationController
  before_action :authenticate_user!

  def new
  end

  def self.search(search)
    if search
      where(:all, :conditions => ['title LIKE ?', "%#{search}%"])
    else
      where(:all)
    end
  end

  def index
    @categories = Categorie.all
    @articles = Article.all

    if params[:search]
      @articles = Article.where('title LIKE :keyword', { :keyword => "%#{params[:search]}%"}).paginate(:page => params[:page], :per_page => 2)
    elsif params[:categorie]
      @articles = Article.where('categorie_id = :categorie', { :categorie => params[:categorie]}).paginate(:page => params[:page], :per_page => 2)
    else
      @articles = Article.all.paginate(:page => params[:page], :per_page => 2)
    end
  end

  def show
    @article = Article.find(params[:id])
  end

  def edit
    @article = Article.find(params[:id])

    if @article.user != current_user
      redirect_to articles_path
    end
  end

  def update
    @article = Article.find(params[:id])

    if @article.update(article_params)
      redirect_to articles_path
    else
      render 'edit'
    end
  end

  def create
    @article = Article.new(article_params)
    @article.user = current_user
    @article.save
    redirect_to articles_path
  end

  def destroy
    @article = Article.find(params[:id])

    if @article.user != current_user
      redirect_to articles_path
    end

    @article.destroy

    redirect_to articles_path
  end

  private
  def article_params
    params.require(:article).permit(:title, :description, :price, :image,:categorie_id)
  end
end
