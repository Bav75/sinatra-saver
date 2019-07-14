require "./config/environment"


class ApplicationController < Sinatra::Base

    configure do 
        enable :sessions

        register Sinatra::Flash

        set :public_folder, "public"
        set :session_secret, "test"
        set :views, 'app/views'
    end

    get '/' do
        erb :homepage
    end

    helpers do 
        def logged_in?
            !!current_user
        end

        def current_user
            @current_user ||= User.find_by(id: session[:user_id])
        end

    end

end