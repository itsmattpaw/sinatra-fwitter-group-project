require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    enable :sessions
    set :session_secret, 'Sysrandom.hex(64)'
    set :views, 'app/views'
  end

  get '/' do
    erb :index
  end

  private 

  def current_user 
    User.find_by_id(session[:user_id])
  end

  def logged_in?
    !!current_user
  end

  def redirect_if_not_logged_in
    if !logged_in?
      redirect "/login"
    end
  end

end
