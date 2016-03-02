class AddColumnsToAdmins < ActiveRecord::Migration
  def change
    add_column :admins, :address, :string
    add_column :admins, :cell, :string
    add_column :admins, :contact, :string
    add_column :admins, :email, :string
    add_column :admins, :website, :string
    add_column :admins, :state, :string
  end
end
