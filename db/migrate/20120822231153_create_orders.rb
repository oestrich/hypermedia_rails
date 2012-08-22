class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.date :date
      t.string :status
      t.integer :total_cents
      t.integer :user_id

      t.timestamps
    end
  end
end
