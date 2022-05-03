
class UsersController < ApplicationController

    get '/login' do
        if logged_in?
            redirect '/tweets/index'
        else  
            erb :"users/login"
        end
    end

    post '/login' do
        user = User.find_by(:username => params[:username])
		if user && user.authenticate(params[:password])
			session[:user_id] = user.id
            redirect '/tweets'
        end
        erb :"users/error"
    end


    get '/signup' do 
        if logged_in?
            redirect "/tweets"
        end
        erb :"users/create_user"
    end

    post '/signup' do
        if params[:username].length > 0 && params[:email].length > 0 && params[:password].length > 0
            @user = User.create(username: params[:username], password: params[:password], email: params[:email])
            session[:user_id] = @user.id
            redirect "/tweets"
        end
        redirect "/users/signup"
    end

    get '/logout' do
        if logged_in?
            session.clear
            redirect "/login"
        end
        redirect "/"
    end

    get '/users/:slug' do
        @user = User.find_by_slug(params[:slug])
        erb :"users/show"
    end

end
