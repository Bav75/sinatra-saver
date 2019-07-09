class CreateSavingsGoals < ActiveRecord::Migration[5.2]
  def change
    create_table :savings_goals do |t|
      t.string :name
      t.decimal :goal_amount
      t.decimal :current_amount
      t.integer :user_id 
      t.integer :transaction_id
      t.timestamps
    end
  end
end
