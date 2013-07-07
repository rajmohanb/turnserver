class AddTurnUsernameToUser < ActiveRecord::Migration
  def change
    add_column :users, :turn_username, :string
    add_index :users, :turn_username
  end
end
