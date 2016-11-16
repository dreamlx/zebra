class CreateCounts < ActiveRecord::Migration
  def change
    create_table :counts do |t|
      t.integer :current_num

      t.timestamps null: false
    end
  end
end
