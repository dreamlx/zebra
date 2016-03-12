class CreateThirdparties < ActiveRecord::Migration
  def change
    create_table :thirdparties do |t|
      t.string :code
      t.string :name
      t.string :image
      t.string :state

      t.timestamps null: false
    end
  end
end
