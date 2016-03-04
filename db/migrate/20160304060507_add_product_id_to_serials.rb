class AddProductIdToSerials < ActiveRecord::Migration
  def change
    add_column :serials, :product_id, :integer

    add_index :serials, :product_id
  end
end
