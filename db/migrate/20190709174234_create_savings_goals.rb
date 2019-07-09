class CreateSavingsGoals < ActiveRecord::Migration[5.2]
  def change
    create_table :savings_goals do |t|
      t.string :name
      t.decimal :goal_amount
      t.decimal :current_amount
      t.datetime :created_at, null: false
      t.datetime :updated_at, null: false 
      t.integer :user_id 
    end
  end
end
