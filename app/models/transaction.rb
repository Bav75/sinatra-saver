class Transaction < ActiveRecord::Base
    belongs_to :savings_goal
end