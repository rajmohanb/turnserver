class AddParamsToCustomer < ActiveRecord::Migration
  def change
    add_column :customers, :realm, :string
    add_column :customers, :first_name, :string
    add_column :customers, :last_name, :string
    add_column :customers, :organization, :string
  end
end
