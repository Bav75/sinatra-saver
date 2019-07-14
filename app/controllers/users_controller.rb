class UsersController < ApplicationController

    get '/users/new' do 
        if logged_in?
            redirect "/users/#{current_user.id}"
        else
            erb :'/users/signup'
        end
    end

    post '/users' do
        email = params[:email]
        name = params[:name]
        pass = params[:password]

        if email.empty? || name.empty? || pass.empty?
            flash[:alert] = "Please enter the requested signup details"
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
            redirect "/users/#{current_user.id}"
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
            @user = User.find_by(id: params[:user_id])
            if @user && (@user == current_user)
                erb :'/users/show'
            else
                redirect '/'
            end
        else
            redirect '/login'
        end
    end
    
    get '/users/:user_id/edit' do
        if logged_in?
            @user = User.find_by(id: params[:user_id])
            if @user && (@user == current_user)
                erb :'/users/edit'
            else
                redirect '/'
            end
        else
            redirect '/login'
        end
    end

    get '/users/:user_id/balance' do
        if logged_in?
            @user = User.find_by(id: params[:user_id])
            if @user && (@user == current_user)
                erb :'/users/balance'
            else
                redirect '/'
            end
        else
            redirect '/login'
        end
    end

    patch '/users/:user_id' do
        if logged_in?
            @user = User.find_by(id: params[:user_id])
            if @user && (@user == current_user)
                if params[:account_balance]
                    @user.update(account_balance: @user.account_balance + params[:account_balance].to_i)
                elsif params[:email]
                    @user.update(email: params[:email])
                end
                redirect "/users/#{@user.id}"
            else
                redirect '/'
            end
        else
            redirect '/login'
        end
    end

    delete '/users/:user_id' do
        if logged_in?
            @user = User.find_by(id: params[:user_id])
            if @user && (@user == current_user)
                @user.delete
                redirect '/signup'
            else
                redirect '/users/new'
            end
        else
            redirect '/login'
        end
    end
    

end