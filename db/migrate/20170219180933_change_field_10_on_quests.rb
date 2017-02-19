class ChangeField10OnQuests < ActiveRecord::Migration
  def up
    change_column :quests, :field_10, :string, :limit => 2000
  end

  def down
    change_column :quests, :field_10, :string, :limit => 255
  end
end
