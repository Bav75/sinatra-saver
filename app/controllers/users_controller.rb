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

    post '/logout' do
        if logged_in?
            session.clear
            redirect '/login'
        end
    end

    get '/users/:user_id' do
        if logged_in?
            #validate user is accessing only their profile page
            if session[:user_id] == params[:user_id].to_i
                erb :'/users/show'
            #kick them to homepage if not 
            else
                redirect '/'
            end
        else
            redirect '/login'
        end
    end
    
    get '/users/:user_id/balance' do
        if logged_in?
            # replace if session[:id] with current_user 
            if session[:user_id] == params[:user_id].to_i
                erb :'/users/balance'
            else
                redirect '/'
            end
        else
            redirect '/login'
        end
    end

    patch '/users/:user_id' do
        # binding.pry
        if logged_in?
            @user = User.find_by(id: params[:user_id])
            if @user && (@user == current_user)
                @user.update(account_balance: @user.account_balance + params[:account_balance].to_i)
                redirect "/users/#{@user.id}"
            else
                redirect '/'
            end
        else
            redirect '/login'
        end

    end
    

end