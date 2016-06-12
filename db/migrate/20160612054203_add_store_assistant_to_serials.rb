class AddStoreAssistantToSerials < ActiveRecord::Migration
  def change
    add_column :serials, :store_assistant_id, :integer
  end
end
