class AddUserIdToEphemeralCredential < ActiveRecord::Migration
  def change
    add_column :ephemeral_credentials, :user_id, :integer
    add_index :ephemeral_credentials, :user_id
  end
end
