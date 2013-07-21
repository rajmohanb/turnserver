class CreateEphemeralCredentials < ActiveRecord::Migration
  def change
    create_table :ephemeral_credentials do |t|
      t.string :username
      t.string :secret

      t.timestamps
    end

    add_index :ephemeral_credentials, :username, :unique => true
  end
end
