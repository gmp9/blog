class ArticlesController < ApplicationController
  before_action :authenticate_user!
  after_action :verify_authorized
  
  def index
    @articles = Article.all
    authorize User
  end
  
  def new
    @article = Article.new
    @user = User.new
    authorize @user
  end
  
  def edit
    @article = Article.find(params[:id])
    authorize User
  end
  
  def show
    @article = Article.find(params[:id])
    authorize User
  end
  
  def create
    @article = Article.new(article_params)
    authorize User   # there is no instance of the User class, no @user
 
    #save the model to the database
    if @article.save
      #redirect the user to the show action
      redirect_to @article
    else
      render 'new'
    end
  end
  
  def update
    @article = Article.find(params[:id])
    authorize User
 
    if @article.update(article_params)
      redirect_to @article
    else
      render 'edit'
    end
  end
  
  def destroy
    @article = Article.find(params[:id])
    authorize User
    
    #go ahead use the method destroy to get rid of the entry
    @article.destroy
 
    redirect_to articles_path
  end
  
  private
  
    def article_params
      params.require(:article).permit(:title, :text)
    end
    
    #def secure_params
     # params.require(:user).permit(:role)
    #end
end
