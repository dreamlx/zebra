class AddProductLogoToProducts < ActiveRecord::Migration
  def change
    add_column :products, :product_logo, :string
    add_column :products, :desc, :string
  end
end
