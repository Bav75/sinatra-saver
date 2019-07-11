class UsersController < ApplicationController


    #display index of users 
    get '/users' do
        @users = User.all
        erb :'/users/index' 
    end

    #display form to signup new user
    get '/users/new' do 
        if logged_in?
            redirect '/users/:user_id'
        else
            erb :'/users/signup'
        end
    end

    post '/users' do
        email = params[:email]
        name = params[:name]
        pass = params[:password]

        if email.empty? || name.empty? || pass.empty?
            "Please enter the requested signup details"
            redirect '/users/new'
        else
            @user = User.new(
                name: name,
                email: email,
                password: pass,
                account_balance: 0
            )

            if @user.save 
                redirect '/login'
            else
                redirect '/users/new'
            end
        end
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