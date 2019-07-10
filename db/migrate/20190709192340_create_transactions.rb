class CreateTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :transactions do |t|
      t.decimal :amount 
      t.integer :goal_id 
      t.timestamps
    end
  end
end