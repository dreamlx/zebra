class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :shop_store_id
      t.integer :serial_id
      t.date :order_date

      t.timestamps null: false
    end
    add_index :orders, :shop_store_id
  end
end
