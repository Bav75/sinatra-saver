class UsersController < ApplicationController


    get '/signup' do 
        erb :signup
        #display form to signup new user
    end

    post '/signup' do
        #receives post data from
        #user signup form 

        email = params[:email]
        name = params[:name]
        pass = params[:password]

        #checking to see if alrdy logged in 
        #post data validity / checking 

        #if data valid then create & save 
        @user = User.create({
            name: name,
            email: email,
            password: pass
        })
        #else
        #return to signup page & prompt for
        #valid data entry 

        #once created, redirect to login page 
    end

    

    get '/users' do
        "Here are my users" 
    end

end