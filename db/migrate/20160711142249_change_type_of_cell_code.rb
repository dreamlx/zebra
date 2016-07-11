class ChangeTypeOfCellCode < ActiveRecord::Migration
  def change
    change_column :cell_codes, :cell,  :string
  end
end
