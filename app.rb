# frozen_string_literal: true

require 'sinatra/base'
require 'sinatra/reloader'
require 'rack'
require 'sinatra/flash'
require './lib/users'

class CloudStay < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end
  register Sinatra::Flash
  enable :sessions

  get '/' do
    erb(:'/login/sign_in')
  end

  post '/sessions' do
    user = User.authenticate_user(username: params[:username], password: params[:password])
    if user
      session[:user_id] = user.id
      redirect('/clouds')
    else
      flash[:notice] = 'Please check your email or password.'
      redirect('/')
    end
  end 

  get '/sign_up' do
    erb(:'/login/new')
  end

  post '/users' do
    user = User.user_create(username: params[:username], password: params[:password])
    session[:user_id] = user.id
    redirect '/'
  end

  get '/clouds' do
    erb :clouds
  end
end
