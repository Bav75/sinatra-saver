class UsersController < ApplicationController


    #display index of users 
    get '/users' do
        @users = User.all
        erb :'/users/index' 
    end

    #display form to signup new user
    get '/users/new' do 
        if logged_in?
            redirect "/users/#{session[:user_id]}"
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
        if logged_in?
            redirect '/users/:user_id'
        else
            erb :'/users/login'
        end
    end

    post '/login' do
        email = params[:email]
        password = params[:password]

        if email.empty? || password.empty?
            redirect '/login'
        else
            @user = User.find_by(email: email)

            if @user && @user.authenticate(password)
                session[:user_id] = @user.id
                redirect "/users/#{@user.id}"
            else
                redirect '/login'
            end
        end 
    end

    get '/users/:user_id' do
        "this is user #{session[:user_id]}'s page!"
        #show the users homepage

    end

    

end