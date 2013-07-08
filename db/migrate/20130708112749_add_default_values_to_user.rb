class AddDefaultValuesToUser < ActiveRecord::Migration
  def change
    change_column :users, :allocs, :integer, :default => 0
    change_column :users, :active_allocs, :integer, :default => 0
    change_column :users, :bandwidth_used, :integer, :default => 0
  end
end
