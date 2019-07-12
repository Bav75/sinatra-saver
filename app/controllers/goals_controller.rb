class GoalsController < ApplicationController

   get '/goals' do
    @goals = Goal.all
    erb :'/goals/index'
   end

   get '/goals/new' do
    erb :'/goals/new'
   end

   post '/goals' do
    name = params[:name]
    goal_amount = params[:goal_amount]

    if name.empty? || goal_amount.empty? || (goal_amount.to_i == 0)
        redirect '/goals/new'
    else
        @goal = current_user.goals.build(
            name: name,
            goal_amount: goal_amount,
            current_amount: 0
        )
        if @goal.save 
            redirect '/goals/:goal_id'
        else
            redirect '/goals/new'
        end
    end
   end

   get '/goals/:goal_id' do
    if logged_in?
        @goal = Goal.find_by(id: params[:goal_id])
        if @goal && (@goal.user == current_user)
            erb :'/goals/show'
        else
            redirect '/'
        end
    else
        redirect '/login'
    end 
   end


end