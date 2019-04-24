
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    set :method_override, true
  end

  get '/' do
    redirect to '/articles'
  end

  get '/articles' do
    @articles = Article.all
    erb :index
  end

  get '/articles/new' do
    @article = Article.new
    erb :new
  end

  get '/articles/:id' do
    @article = Article.find(params[:id])
    erb :show
  end

  post '/articles' do
    @article = Article.create(params)
    redirect to "/articles/#{@article.id}"
  end

# edit
  get '/articles/:id/edit' do
    @article = Article.find(params[:id])
    erb :edit
  end
# update
  patch '/articles/:id' do
    @article = Article.find(params[:id])
    params.delete("_method")
    @article.update(params[:article])
    redirect to "/articles/#{@article.id}"
  end

  delete '/articles/:id' do
    Article.destroy(params[:id])
    redirect to '/articles'
  end

end
