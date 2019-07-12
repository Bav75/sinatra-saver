class GoalsController < ApplicationController

   get '/goals' do
    @goals = []
    Goal.all.each do |goal|
        if goal.user == current_user
            @goals << goal
        end
    end
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

   get '/goals/:goal_id/edit' do
    if logged_in?
        @goal = Goal.find_by(id: params[:goal_id])
        if @goal && (@goal.user == current_user)
            erb :'/goals/edit'
        else
            redirect '/'
        end
    else
        redirect '/login'
    end 
   end

   patch '/goals/:goal_id' do
    if logged_in?
        @goal = Goal.find_by(id: params[:goal_id])
        if @goal && (@goal.user == current_user)
            if params[:contribution]
                @goal.update(current_amount: @goal.current_amount + params[:contribution].to_i)
            else
                @goal.update(
                    name: params[:name],
                    goal_amount: params[:goal_amount]
                )
            end
            redirect "/goals/#{@goal.id}"
        else
            redirect '/'
        end
    else
        redirect '/login'
    end
   end


end