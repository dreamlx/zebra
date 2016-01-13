class CreateRecords < ActiveRecord::Migration
  def change
    create_table :records do |t|
      t.references :user, index: true, foreign_key: true
      t.string :city
      t.string :prize
      t.string :code

      t.timestamps null: false
    end
  end
end
