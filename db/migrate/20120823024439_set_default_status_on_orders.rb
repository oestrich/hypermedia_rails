class SetDefaultStatusOnOrders < ActiveRecord::Migration
  def up
    change_column :orders, :status, :string, :default => "pending"
  end

  def down
    change_column :orders, :status, :string
  end
end
