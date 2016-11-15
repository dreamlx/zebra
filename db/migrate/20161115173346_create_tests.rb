class CreateTests < ActiveRecord::Migration
  def change
    create_table :tests do |t|
      t.string :form
      t.string :form_name
      t.string :serial_number
      t.string :field_1
      t.string :field_5
      t.string :field_6
      t.string :field_7
      t.string :field_8
      t.string :field_9
      t.string :creator_name

      t.timestamps null: false
    end
  end
end
