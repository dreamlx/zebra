class CreateCellCodes < ActiveRecord::Migration
  def change
    create_table :cell_codes do |t|
      t.integer :cell
      t.integer :code

      t.timestamps null: false
    end
  end
end
