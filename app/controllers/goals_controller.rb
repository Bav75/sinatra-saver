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
                @goal.transactions.create(amount: params[:contribution].to_i)
                @transaction_total = 0 
                Transaction.all.each do |transaction|
                    if transaction.goal == @goal
                        @transaction_total += transaction.amount
                    end
                end
                @goal.update(current_amount: @transaction_total)
                # @goal.update(current_amount: @goal.current_amount + params[:contribution].to_i)
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


   delete '/goals/:goal_id' do
    if logged_in?
        @goal = Goal.find_by(id: params[:goal_id])
        binding.pry
        if @goal && (@goal.user == current_user)
            @goal.delete
            redirect '/goals'
        else
            redirect "/users/#{current_user.id}"
        end
    else
        redirect '/login'
    end
   end



end