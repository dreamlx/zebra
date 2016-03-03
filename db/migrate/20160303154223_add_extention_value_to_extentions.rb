class AddExtentionValueToExtentions < ActiveRecord::Migration
  def change
    add_column :extentions, :extention_value, :string
  end
end
