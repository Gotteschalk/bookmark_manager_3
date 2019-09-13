# frozen_string_literal: true

require 'sinatra/base'
require './lib/bookmark.rb'
require './lib/database_connection_setup'

# BookmarkManager inherits from Sinatra/Base
class BookmarkManager < Sinatra::Base
  enable :sessions, :method_override

  get '/' do
    erb :index
  end

  get '/bookmarks' do
    @bookmarks = Bookmark.all
    erb :'bookmarks/index'
  end

  get '/add' do
    erb :add
  end

  post '/confirmation' do
    Bookmark.add(params[:title], params[:url])
    redirect '/bookmarks'
  end

  delete '/bookmarks/:id' do
    # connection = PG.connect(dbname: 'bookmark_manager_test')
    Bookmark.delete(params['id'])
    redirect '/bookmarks'
  end

  get '/bookmarks/:id/edit' do
    @bookmark = Bookmark.find(params[:id])
    erb :'bookmarks/edit'
  end

  patch '/bookmarks/:id' do
    Bookmark.update(params['id'], params['title'], params['url'])
    redirect '/bookmarks'
  end
end
