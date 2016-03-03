class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :product_name
      t.string :product_image
      t.integer :admin_id
      t.string :state

      t.timestamps null: false
    end
  end
end
