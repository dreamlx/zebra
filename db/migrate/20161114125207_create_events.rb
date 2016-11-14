class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :from
      t.string :from_name
      t.string :serial_number
      t.string :field_1
      t.string :field_2
      t.string :field_8
      t.string :field_9
      t.string :field_15
      t.string :gen_code
      t.string :status

      t.timestamps null: false
    end
  end
end
