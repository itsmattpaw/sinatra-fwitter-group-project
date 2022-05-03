class TweetsController < ApplicationController

    get '/tweets' do
        redirect_if_not_logged_in
        erb :"tweets/tweets"
    end

    get '/tweets/new' do
        redirect_if_not_logged_in
        erb :"tweets/new"
    end

    post '/tweets/new' do
        if params[:content].length > 0
            @user = current_user
            @tweet = Tweet.create(content: params[:content], user_id: @user.id)
            redirect "/tweets/#{@tweet.id}"
        end
        erb :"tweets/new"
    end

    get '/tweets/:id/edit' do
        redirect_if_not_logged_in
        @tweet = Tweet.find(params[:id])
        if @tweet.user_id = current_user.id
            erb :"tweets/edit_tweet"
        end
    end

    patch '/tweets/:id' do
        @tweet = Tweet.find(params[:id])
        if params[:content].length > 0
            if @tweet.user_id == current_user.id
                @tweet.update(content: params[:content])
            end
            redirect "/tweets/#{@tweet.id}"
        end
        redirect "/tweets/#{@tweet.id}/edit"
    end

    delete '/tweets/:id' do
        @tweet = Tweet.find(params[:id])
        if @tweet.user_id == current_user.id
            @tweet.delete
        end
        erb :"tweets/tweets"
    end

    get '/tweets/:id' do
        redirect_if_not_logged_in
        @tweet = Tweet.find(params[:id])
        erb :"tweets/show_tweet"
    end

end
