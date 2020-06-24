
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end


  get ('/') {

  }

  # GET our index page of all the articles.
  get ('/articles') {
    @articles = Article.all
    erb :index
  }

  # Form to fill out a new article.
  get ('/articles/new') {
    erb :new
  }

  # Use info from the form above to actually CREATE a new article.
  # Once you press submit, it will take you to the specific page to view just
  # that article. ('/articles/:id')
  post ('/articles') {
    @article = Article.create(params)
    redirect to "/articles/#{ @article.id }"
  }

  # See a specific article page.
  get ('/articles/:id') {
    @article = Article.find(params[:id])
    erb :show
  }

  # Find a specific article and then send it to the edit page.
  get "/articles/:id/edit" do
    @article = Article.find(params[:id])
    erb :edit
  end

  # Use 'patch' to update an existing article, which is sent from edit.erb.
  patch "/articles/:id" do
    @article = Article.find(params[:id])
    @article.update(params[:article])
    redirect to "/articles/#{ @article.id }"
  end

  # Delete a specific article using a delete button(form) on show.erb.
  delete "/articles/:id" do
    Article.destroy(params[:id])
    redirect to "/articles"
  end


end
