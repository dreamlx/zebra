class ChangeOpenidToSerials < ActiveRecord::Migration
  def change
    change_column :serials, :open_id,  :string
  end
end
