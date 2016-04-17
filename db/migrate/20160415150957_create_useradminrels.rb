class CreateUseradminrels < ActiveRecord::Migration
  def change
    create_table :useradminrels do |t|
      t.integer :user_id
      t.integer :admin_id

      t.timestamps null: false
    end
    add_index :useradminrels, :admin_id
  end
end
