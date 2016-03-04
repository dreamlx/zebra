class AddStateToSerials < ActiveRecord::Migration
  def change
    add_column :serials, :state, :string
  end
end
