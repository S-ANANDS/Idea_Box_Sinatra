require 'bundler'
Bundler.require
require './idea'
require_relative 'idea_store'

class IdeaBoxApp < Sinatra::Base
  set :method_override, true

  configure :development do
    register Sinatra::Reloader
  end

  get '/' do
    erb :index, locals:{ideas: IdeaStore.all}
  end
 
  not_found do
    erb :error
  end

  post '/' do
    idea = Idea.new(params[:idea])
    idea.save
    redirect '/'
  end
  
  

  delete '/:id' do |id|
    Idea.delete(id.to_i)
    redirect '/'
  end

  get '/:id/edit' do |id|
    idea = Idea.find(id.to_i)
    erb :edit, locals: {id: id, idea: idea}
  end
  
  post '/' do
    IdeaStore.create(params[:idea])
    redirect '/'
  end
  
  

  put '/:id' do |id|
    Idea.update(id.to_i, params[:idea])
    redirect '/'
  end
  
  
  
  
  
end
