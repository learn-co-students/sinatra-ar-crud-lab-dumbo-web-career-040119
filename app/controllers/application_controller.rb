
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
  redirect to '/articles'
end


  # index Page
  get "/articles" do
    @articles = Article.all
    erb :index
  end

  # Create Form page
  get "/articles/new" do
    @article = Article.new
    erb :new
  end

  # Submit Form
  post "/articles" do
    @article = Article.create(params)
    redirect to "/articles/#{ @article.id }"
  end

  # View New(created insrance page)
  get "/articles/:id" do
    @article = Article.find(params[:id])
    erb :show
  end

  #Edit page
  get "/articles/:id/edit" do
    @article = Article.find(params[:id])
    erb :edit
  end

  # Submit Edit Form data to db
  patch "/articles/:id" do
    @article = Article.find(params[:id])
    @article.update(params[:article])
    redirect to "/articles/#{ @article.id }"
  end

  #delete instance from show page
  delete "/articles/:id" do
    Article.destroy(params[:id])
    redirect to "/articles"
  end
end
