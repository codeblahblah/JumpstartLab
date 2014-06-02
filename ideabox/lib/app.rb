require 'idea_box'

class IdeaBoxApp < Sinatra::Base
  set :method_override, true
  set :root, 'lib/app'

  DAY_OF_THE_WEEK = ['Sunday','Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday']

  configure :development do
    register Sinatra::Reloader
  end

  not_found do
    haml :error
  end


  delete '/:id' do |id|
    IdeaStore.delete(id.to_i)
    redirect '/'
  end

  get '/' do
    haml :index, locals: {ideas: IdeaStore.all.sort, idea: Idea.new}
  end

  get '/:id/edit' do |id|
    idea = IdeaStore.find(id.to_i)
    haml :edit, locals: {idea: idea}
  end

  get '/slot/:id' do |id|
    haml :show_by_slot, locals: {ideas: IdeaStore.find_by_time_slot(id.to_i), slot: id.to_i}
  end

  get '/day/:id' do |id|
    haml :show_by_day, locals: {ideas: IdeaStore.find_by_day(id.to_i), created_on: DAY_OF_THE_WEEK[id.to_i] }
  end

  get '/tags/:id' do |id|
    haml :show_by_tag, locals: {ideas: IdeaStore.find_by_tag(id), tag: id }
  end

  post '/' do
    idea = Idea.new(params[:idea])
    idea.save
    redirect '/'
  end

  post '/:id/like' do |id|
    idea = IdeaStore.find(id.to_i)
    idea.like!
    IdeaStore.update(id.to_i, idea.to_h)
    redirect '/'
  end

  put '/:id' do |id|
    IdeaStore.update(id.to_i, params[:idea])
    redirect '/'
  end
end
