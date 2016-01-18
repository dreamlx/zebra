class CreateSerials < ActiveRecord::Migration
  def change
    create_table :serials do |t|
      t.string :phone
      t.string :open_id
      t.integer :user_id
      t.string :serial_no

      t.timestamps null: false
    end
  end
end
