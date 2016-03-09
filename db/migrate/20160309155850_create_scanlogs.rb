class CreateScanlogs < ActiveRecord::Migration
  def change
    create_table :scanlogs do |t|
      t.integer :user_id
      t.integer :serial_id
      t.integer :current_score

      t.timestamps null: false
    end
  end
end
