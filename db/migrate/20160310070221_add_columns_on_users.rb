class AddColumnsOnUsers < ActiveRecord::Migration
  def change
    add_column :users, :birthday, :date
    add_column :users, :level, :string
  end
end
