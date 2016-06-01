class CreateShopStores < ActiveRecord::Migration
  def change
    create_table :shop_stores do |t|
      t.string :title
      t.string :code
      t.string :contact
      t.string :mobile
      t.string :address

      t.timestamps null: false
    end
  end
end
