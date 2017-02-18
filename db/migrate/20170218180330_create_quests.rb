class CreateQuests < ActiveRecord::Migration
  def change
    create_table :quests do |t|
      t.string :form
      t.string :form_name
      t.string :serial_number
      t.string :field_10
      t.string :creator_name

      t.timestamps null: false
    end
  end
end
