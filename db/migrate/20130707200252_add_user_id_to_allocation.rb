class AddUserIdToAllocation < ActiveRecord::Migration
  def change
    add_column :allocations, :user_id, :integer
    add_index :allocations, :user_id
  end
end
