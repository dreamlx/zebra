class CreatePrizes < ActiveRecord::Migration
  def change
    create_table :prizes do |t|
      t.string :city
      t.integer :free_charge
      t.decimal :free_charge_ratio, precision: 10, scale: 8
      t.integer :fifty_discount
      t.decimal :fifty_discount_ratio, precision: 10, scale: 8
      t.integer :thirty_discount
      t.decimal :thirty_discount_ratio, precision: 10, scale: 8
      t.integer :ten_discount
      t.decimal :ten_discount_ratio, precision: 10, scale: 8
      t.integer :red_envelop
      t.decimal :red_envelop_ratio, precision: 10, scale: 8

      t.timestamps null: false
    end
  end
end
