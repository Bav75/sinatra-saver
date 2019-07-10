require "./config/environment"

class ApplicationController < Sinatra::Base

    configure do 
        enable :sessions

        set :session_secret, "test"
        set :views, 'app/views'
    end

    get '/' do
        erb :homepage
    end

    

end