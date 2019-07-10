class UsersController < ApplicationController


    get '/users' do
        "Here are all of my users" 
    end

    get '/users/new' do 
        erb :'/users/signup'
        #display form to signup new user
    end

    post '/users' do
        #receives post data from
        #user signup form 

        email = params[:email]
        name = params[:name]
        pass = params[:password]

        binding.pry

        #checking to see if alrdy logged in 
        #post data validity / checking 

        #if data valid then create & save 
            @user = User.create(
                name: name,
                email: email,
                password: pass,
                account_balance: 0
            )
        #else
            #return to signup page & prompt for
            #valid data entry 

            #once created, redirect to login page 
    end

    get '/login' do

        #if not already logged in
            #display login page 
        #else redirect to logged_in users
        #page 
            

    end

    post '/login' do

        #receive login credentials

        email = params[:email]
        password = params[:password]

        @user = User.find_by(email: email)

        # if @user && @user.authenticate(password)
        #     session[:user_id] = @user.id

        #if login credentials validated
                #log user in by adding id 
                #to session hash 

                #redirect to users homepage 
                #upon successful login
            #else
                

    end

    get '/users/:user_id' do

        #show the users homepage

    end

    

end