class ChangeStateOnUsers < ActiveRecord::Migration
  def change
    change_column :users, :state, :string

    User.update_all(state: "提交")
  end
end
