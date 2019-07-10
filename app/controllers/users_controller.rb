class UsersController < ApplicationController


    get '/signup' do 
        erb :signup
    end

    get '/users' do
        "Here are my users" 
    end

end