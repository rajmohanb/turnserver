class AddTurnParamsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :max_allocs, :integer
    add_column :users, :max_concur_allocs, :integer
    add_column :users, :def_lifetime, :integer
    add_column :users, :max_bandwidth, :integer
    add_column :users, :turn_secret, :string
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :allocs, :integer
    add_column :users, :active_allocs, :integer
    add_column :users, :bandwidth_used, :integer
  end
end
