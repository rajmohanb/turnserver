class RemoveWebAppUrlIndexFromCustomers < ActiveRecord::Migration
  def up
    remove_index :customers, :webapp_url
    change_column :customers, :webapp_url, :string, :default => ""
  end

  def down
    change_column :customers, :webapp_url, :string, :null => false
    add_index :customers, :webapp_url, unique: true
  end
end
