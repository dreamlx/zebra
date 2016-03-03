class CreateExtentions < ActiveRecord::Migration
  def change
    create_table :extentions do |t|
      t.integer :product_id
      t.string :extention_name
      t.integer :extention_type

      t.timestamps null: false
    end
  end
end
