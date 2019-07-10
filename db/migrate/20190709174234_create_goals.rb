class CreateGoals < ActiveRecord::Migration[5.2]
  def change
    create_table :goals do |t|
      t.string :name
      t.decimal :goal_amount
      t.decimal :current_amount
      t.integer :user_id 
      t.timestamps
    end
  end
end
