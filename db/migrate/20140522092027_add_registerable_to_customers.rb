class AddRegisterableToCustomers < ActiveRecord::Migration
  def self.up

    #confirmable
    add_column :customers, :confirmation_token, :string
    add_column :customers, :confirmed_at, :datetime
    add_column :customers, :confirmation_sent_at, :datetime
    add_column :customers, :unconfirmed_email, :string # Only if using reconfirmable


    # recoverable
    add_column :customers, :reset_password_token, :string
    add_column :customers, :reset_password_sent_at, :datetime

    add_index :customers, :confirmation_token, :unique => true
    add_index :customers, :reset_password_token, :unique => true

    # mark existings users as confirmed
    Customer.update_all(:confirmed_at => Time.now)
    # all existings users must be able to login after this
  end

  def self.down
    remove_columns :customers, :confirmation_token
    remove_columns :customers, :confirmed_at
    remove_columns :customers, :confirmation_sent_at
    remove_columns :customers, :unconfirmed_email

    remove_columns :customers, :reset_password_token
    remove_columns :customers, :reset_password_sent_at
  end
end
