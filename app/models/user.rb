class User < ActiveRecord::Base
    has_secure_password

    has_many :savings_goals
end
