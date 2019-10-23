
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    redirect to '/articles'
  end

  get '/articles' do
    @articles = Article.all
    erb :index
  end

  post '/articles' do
    @article = Article.create(params)
    if @article
      redirect "/articles/#{@article.id}"
    else
      "Failed to Create Article(s)"
    end
  end

  delete '/articles/:id' do
    params.delete("_method")
    @article = Article.find_by_id(params[:id])
    @article.delete
    redirect to '/articles'
  end

  patch '/articles/:id' do
    params.delete("_method")
    @article = Article.find_by(id: params[:id].to_i)
    if @article.update(params)
      redirect to "/articles/#{@article.id}"
    else
      puts "Error updating Post!"
    end
  end


  get '/articles/new' do
    erb :new
  end

  get '/articles/:id' do
    @article = Article.find_by_id(params[:id])
    erb :show
  end

  get '/articles/:id/edit' do
    @article = Article.find_by_id(params[:id])
    erb :edit
  end

end
