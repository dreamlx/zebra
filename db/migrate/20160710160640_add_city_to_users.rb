class AddCityToUsers < ActiveRecord::Migration
  def change
    add_column :users, :city, :string
    add_column :users, :store, :string
    add_column :users, :department, :string
  end
end
